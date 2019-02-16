//
//  UnusedFileAnalyzerStepTests.swift
//  XcodeMissingFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

@testable import XcodeMissingFramework
import XCTest

class UnusedFileAnalyzerStepTests: XCTestCase {
    func testUnusedFilesAreFound() {
        let context = StepPipelineContext(verbose: true, extensions: [], path: "ddasl")
        context.files.add(File(filename: "used", referenceCount: 1))
        context.files.add(File(filename: "unused"))
        let unusedFileAnalyzerStep = UnusedFileAnalyzerStep()
        unusedFileAnalyzerStep.run(context: context)

        XCTAssertEqual(context.unusedFiles.all.count, 1)
        XCTAssertEqual(context.unusedFiles.all[0].filename, "unused")
    }
}
