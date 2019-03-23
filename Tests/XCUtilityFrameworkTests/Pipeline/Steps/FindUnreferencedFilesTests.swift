//
//  FindUnreferencedFilesTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

import PathKit
import XCTest
@testable import XCUtilityFramework

class FindUnreferencedFilesTests: XCTestCase {
    func testUnreferencedFilesAreFound() {
        let config = Configuration(excluded: [], extensions: [], verbose: false, path: "")
        let context = PipelineState(config: config)
        context.files.add(File(filename: "used", referenceCount: 1))
        context.files.add(File(filename: "unused"))
        let testStep = FindUnreferencedFiles()
        testStep.run(context: context)

        XCTAssertEqual(context.unreferencedFiles.all.count, 1)
        XCTAssertEqual(context.unreferencedFiles.all[0].path.string, "unused")
    }
}
