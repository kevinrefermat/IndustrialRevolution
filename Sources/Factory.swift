// Copyright © 2019 Kevin Refermat. All rights reserved.

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

    public convenience init<ConcreteProduct: Makeable>(transformFactory: TransformFactory<ConcreteProduct,Product>) where ConcreteProduct.Configuration==ProductConfiguration {
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

