//
//  FileTests.swift
//  AEXML
//
//  Created by Jeff Lett on 2/15/19.
//

import Foundation
import PathKit
import XCTest
@testable import XCUtilityFramework

class FileTests: XCTestCase {
    func testComparable() {
        let path1 = Path("a")
        let path2 = Path("b")
        let file1 = File(path: path1)
        let file2 = File(path: path2)
        XCTAssert(file1 < file2)
    }

    func testDescription() {
        let path = Path("imapath")
        var file = File(path: path)
        XCTAssertEqual(file.description, "imapath 0")
        file.incrementReferenceCount()
        XCTAssertEqual(file.description, "imapath 1")
    }

    func testConcurrencyOfFileReferences() {
        let num = 10_000
        let path = Path("imapath")
        var file = File(path: path)
        DispatchQueue.concurrentPerform(iterations: num) { _ in
            file.incrementReferenceCount()
        }
        XCTAssertEqual(file.references, num)
    }
}
