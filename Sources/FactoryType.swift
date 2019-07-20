// Copyright © 2019 Kevin Refermat. All rights reserved.

import Foundation

public protocol FactoryType { // maybe call this DynamicFactory or something to indicate that it's a factory that doesn't have knowledge of Dependencies, just Configuration
    associatedtype Product
    associatedtype ProductConfiguration

    func make(configuration: ProductConfiguration) -> Product
}
