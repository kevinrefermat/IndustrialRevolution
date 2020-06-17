// Copyright © 2019 Kevin Refermat. All rights reserved.

import Foundation

public protocol DependencyContainerProtocol {
    func make<Product: Makeable>(productType: Product.Type, configuration: Product.Configuration) -> Product where Product.Dependencies==Self
}

extension DependencyContainerProtocol {
    public func make<Product: Makeable>(productType: Product.Type, configuration: Product.Configuration) -> Product where Product.Dependencies==Self {
        let product = Product(configuration: configuration, dependencies: self)
        return product
    }

    public func make<Product: Makeable>(productType: Product.Type) -> Product where Product.Dependencies==Self, Product.Configuration==Void {
        let product = Product(configuration: (), dependencies: self)
        return product
    }
}
