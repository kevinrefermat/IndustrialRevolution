// MIT License
//
// Copyright (c) 2022 Kevin Refermat
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

public class Factory<Product: Makeable>: FactoryType, Makeable {
    public struct Dependencies {
        let productDependencies: Product.Dependencies

        public init(productDependencies: Product.Dependencies) {
            self.productDependencies = productDependencies
        }
    }

    private let dependencies: Dependencies

    public required init(configuration: Void, dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public func make(configuration: Product.Configuration) -> Product {
        let product = Product(configuration: configuration, dependencies: dependencies.productDependencies)
        return product
    }
}

public class TransformFactory<Product: Makeable, TransformedProduct>: FactoryType, Makeable {
    public struct Dependencies {
        let factory: Factory<Product>
        let transform: (Product) -> TransformedProduct

        public init(factory: Factory<Product>, transform: @escaping (Product) -> TransformedProduct) {
            self.factory = factory
            self.transform = transform
        }
    }

    private let dependencies: Dependencies

    public required init(configuration: Void, dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public func make(configuration: Product.Configuration) -> TransformedProduct {
        let product = dependencies.factory.make(configuration: configuration)
        let transformedProduct = dependencies.transform(product)
        return transformedProduct
    }
}

public class MockableFactory<ProductConfiguration, Product>: FactoryType, Makeable {
    public struct Dependencies {
        let makeProduct: (ProductConfiguration) -> Product
    }

    private let dependencies: Dependencies

    public convenience init<ConcreteProduct: Makeable>(
        transformFactory: TransformFactory<ConcreteProduct, Product>
    ) where ConcreteProduct.Configuration==ProductConfiguration {
        let dependencies = Dependencies(makeProduct: { (productConfiguration) in
            let product = transformFactory.make(configuration: productConfiguration)
            return product
        })
        self.init(configuration: (), dependencies: dependencies)
    }

    public required init(configuration: Void, dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public func make(configuration: ProductConfiguration) -> Product {
        let product = dependencies.makeProduct(configuration)
        return product
    }
}
