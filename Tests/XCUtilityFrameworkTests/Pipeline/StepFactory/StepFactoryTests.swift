//
//  StepFactoryTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/17/19.
//

import XCTest
@testable import XCUtilityFramework

class StepFactoryTests: XCTestCase {
    func testFindAllFactoryIsReturnedWhenExpected() {
        let factory = AbstractStepFactory.stepFactory(for: .findAll)
        XCTAssertNotNil(factory as? FindAllStepFactory)
    }

    func testFindUnbuiltFactoryIsReturnedWhenExpected() {
        let factory = AbstractStepFactory.stepFactory(for: .findUnbuilt)
        XCTAssertNotNil(factory as? FindUnbuiltStepFactory)
    }

    func testFindUnreferencedFactoryIsReturnedWhenExpected() {
        let factory = AbstractStepFactory.stepFactory(for: .findUnreferenced)
        XCTAssertNotNil(factory as? FindUnreferencedStepFactory)
    }
}
