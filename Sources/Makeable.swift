// Copyright © 2019 Kevin Refermat. All rights reserved.

import Foundation

public protocol Makeable {
    associatedtype Configuration
    associatedtype Dependencies

    init(configuration: Configuration, dependencies: Dependencies)
}

extension Makeable where Self.Configuration==Void {
    public init(dependencies: Dependencies) {
        self.init(configuration: (), dependencies: dependencies)
    }
}

extension Makeable where Self.Dependencies==Void {
    public init(configuration: Configuration) {
        self.init(configuration: configuration, dependencies: ())
    }
}

extension Makeable where Self.Dependencies==Void, Self.Configuration==Void {
    public init() {
        self.init(configuration: (), dependencies: ())
    }
}
