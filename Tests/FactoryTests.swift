// MIT License
//
// Copyright (c) 2022 Kevin Refermat
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
