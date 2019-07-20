// Copyright © 2019 Kevin Refermat. All rights reserved.

import Foundation
import IndustrialRevolution

protocol WidgetProtocol {

}

final class MockWidget: WidgetProtocol {
    
}

final class Widget: WidgetProtocol, Makeable {
    struct Configuration {
        let uuid: UUID
    }

    struct Dependencies {
        let uuid: UUID
    }

    init(configuration: Configuration, dependencies: Dependencies) {

    }
}
