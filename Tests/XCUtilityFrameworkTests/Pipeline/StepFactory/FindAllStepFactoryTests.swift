//
//  FindAllStepFactoryTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/17/19.
//

import XCTest
@testable import XCUtilityFramework

// swiftlint:disable implicitly_unwrapped_optional
class FindAllStepFactoryTests: XCTestCase {
    var testFactory: FindAllStepFactory!

    override func setUp() {
        super.setUp()
        self.testFactory = FindAllStepFactory()
    }

    func testDeleteSteps() {
        let steps = testFactory.steps(delete: true)
        XCTAssertEqual(steps.count, 9)
    }

    func testNonDeleteSteps() {
        let steps = testFactory.steps(delete: false)
        XCTAssertEqual(steps.count, 7)
    }
}
