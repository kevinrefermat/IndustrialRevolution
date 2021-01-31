// Copyright © 2019 Kevin Refermat. All rights reserved.

import Foundation

extension Factory where Product.Configuration==Void {
    public func make() -> Product {
        let product = make(configuration: ())
        return product
    }
}

extension Factory where Product.Dependencies==Void {
    public convenience init() {
        self.init(
            dependencies: .init(
                productDependencies: ()
            )
        )
    }
}

extension MockableFactory where ProductConfiguration == Void {
    public func make() -> Product {
        make(configuration: ())
    }
}

extension Factory {
    public func mockableFactory<TransformedProduct>(
        transform: @escaping (Product) -> (TransformedProduct)
    ) -> MockableFactory<Product.Configuration, TransformedProduct> {
        MockableFactory(
            transformFactory: TransformFactory(
                configuration: (),
                dependencies: TransformFactory.Dependencies(
                    factory: self,
                    transform: transform
                )
            )
        )
    }
}
