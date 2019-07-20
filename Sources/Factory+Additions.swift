// Copyright © 2019 Kevin Refermat. All rights reserved.

import Foundation

extension Factory where Product.Configuration==Void {
    public func make() -> Product {
        let product = make(configuration: ())
        return product
    }
}
