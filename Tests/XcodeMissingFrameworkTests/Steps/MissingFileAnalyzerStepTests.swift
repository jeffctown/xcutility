//
//  MissingFileAnalyzerStepTests.swift
//  XcodeMissingFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

@testable import XcodeMissingFramework
import XCTest

class MissingFileAnalyzerStepTests: XCTestCase {
    func testMissingFilesAreFound() {
        let context = StepPipelineContext(verbose: true, extensions: [], path: "ddasl")
        context.files.add(File(filename: "used", referenceCount: 1))
        context.files.add(File(filename: "unused"))
        let missingFileAnalyzerStep = MissingFileAnalyzerStep()
        missingFileAnalyzerStep.run(context: context)

        XCTAssertEqual(context.missingFiles.all.count, 1)
        XCTAssertEqual(context.missingFiles.all[0].filename, "unused")
    }
}
