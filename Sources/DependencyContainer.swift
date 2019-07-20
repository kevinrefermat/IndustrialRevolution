// Copyright © 2019 Kevin Refermat. All rights reserved.

import Foundation

open class DependencyContainer {
    public init() {}

    open func make<Product: Makeable>(productType: Product.Type, configuration: Product.Configuration) -> Product where Product.Dependencies==DependencyContainer {
        let product = Product(configuration: configuration, dependencies: self)
        return product
    }
}
