// swiftlint:disable:this file_name
//  StringExtensionTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import XCTest
import XCUtilityFramework

final class StringExtensionsTests: XCTestCase {
    func testPathReturnsAPath() {
        let valid = "/Users/hefe/boom.xcodeproj"
        let path = valid.path
        XCTAssertNotNil(path)
        XCTAssertEqual(path.string, valid)
    }
}
