// Copyright © 2019 Kevin Refermat. All rights reserved.

import XCTest
import IndustrialRevolution

class FactoryTests: XCTestCase {
    func test() {
        let widgetDependencies = Widget.Dependencies(uuid: UUID())
        let widgetFactoryDependencies = Factory<Widget>.Dependencies(productDependencies: widgetDependencies)
        let widgetFactoryFactoryDependencies = Factory<Factory<Widget>>.Dependencies(
            productDependencies: widgetFactoryDependencies
        )
        let widgetFactoryFactory = Factory<Factory<Widget>>(
            configuration: (),
            dependencies: widgetFactoryFactoryDependencies
        )
        let widgetFactory = widgetFactoryFactory.make()
        let widget = widgetFactory.make(configuration: .init(uuid: UUID()))

        let widgetProtocolDependencies = TransformFactory.Dependencies(
            factory: widgetFactory,
            transform: { $0 as WidgetProtocol }
        )
        let widgetProtocolFactory = TransformFactory(configuration: (), dependencies: widgetProtocolDependencies)

        let widgetProtocolFactory1 = MockableFactory<Widget.Configuration, WidgetProtocol>(
            transformFactory: widgetProtocolFactory
        )
        let widget1 = widgetProtocolFactory1.make(configuration: .init(uuid: UUID()))

        _ = [widget, widget1]
    }
}
