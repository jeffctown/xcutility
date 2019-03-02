//
//  FindUnreferencedStepFactoryTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/17/19.
//

import XCTest
@testable import XCUtilityFramework

// swiftlint:disable implicitly_unwrapped_optional
class FindUnreferencedStepFactoryTests: XCTestCase {
    var testFactory: FindUnreferencedStepFactory!

    override func setUp() {
        super.setUp()
        self.testFactory = FindUnreferencedStepFactory()
    }

    func testDeleteSteps() {
        let steps = testFactory.steps(delete: true)
        XCTAssertEqual(steps.count, 6)
    }

    func testNonDeleteSteps() {
        let steps = testFactory.steps(delete: false)
        XCTAssertEqual(steps.count, 5)
    }
}
