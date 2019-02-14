//
//  UnusedFileAnalyzerStepTests.swift
//  XcodeMissingFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

import PathKit
@testable import XcodeMissingFramework
import XCTest

class UnusedFileAnalyzerStepTests: XCTestCase {
    func testUnusedFilesAreFound() {
        let context = StepPipelineContext(verbose: true, extensions: [], path: Path("ddasl"))
        context.files["used"] = 1
        context.files["unused"] = 0
        let unusedFileAnalyzerStep = UnusedFileAnalyzerStep()
        unusedFileAnalyzerStep.run(context: context)
        XCTAssert(context.unusedFiles.count == 1)
        XCTAssert(context.unusedFiles[0] == "unused")
    }
}
