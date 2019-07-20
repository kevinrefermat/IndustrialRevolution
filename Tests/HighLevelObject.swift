// Copyright © 2019 Kevin Refermat. All rights reserved.

import Foundation
import IndustrialRevolution

class HighLevelObject {
    let widgetFactory: Factory<Widget>

    init(widgetFactory: Factory<Widget>) {
        self.widgetFactory = widgetFactory
    }
}
