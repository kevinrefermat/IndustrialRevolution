// Copyright © 2019 Kevin Refermat. All rights reserved.

import Foundation

public class FactorySpy<Product: Makeable>: Factory<Product> {
    public private(set) var invocations = [Invocation<Product>]()

    public struct Invocation<Product: Makeable> {
        public let configuration: Product.Configuration
        public let product: Product
    }

    public override func make(configuration: Product.Configuration) -> Product {
        let product = super.make(configuration: configuration)
        let invocation = Invocation(configuration: configuration, product: product)
        invocations.append(invocation)
        return product
    }
}
