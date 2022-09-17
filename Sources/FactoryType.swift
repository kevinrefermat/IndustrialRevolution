// Copyright © 2019 Kevin Refermat. All rights reserved.

import Foundation

public protocol FactoryType {
    associatedtype Product
    associatedtype ProductConfiguration

    func make(configuration: ProductConfiguration) -> Product
}
