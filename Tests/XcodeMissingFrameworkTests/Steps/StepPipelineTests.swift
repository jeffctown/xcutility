//
//  StepPipelineTests.swift
//  XcodeMissingFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

@testable import XcodeMissingFramework
import XCTest

// swiftlint:disable implicitly_unwrapped_optional
class StepPipelineTests: XCTestCase {
    var step: MockStep!
    var context = StepPipelineContext(verbose: true, extensions: [], path: "")

    class MockStep: Step {
        var numRuns = 0

        func run(context: StepPipelineContext) throws {
            numRuns += 1
        }
    }

    enum MockError: Error {
        case mockError
    }

    class MockThrowingStep: Step {
        func run(context: StepPipelineContext) throws {
            throw MockError.mockError
        }
    }

    override func setUp() {
        super.setUp()
        self.step = MockStep()
    }

    func testRunIsCalledOnStep() {
        let pipeline = StepPipeline(steps: [step], context: context)
        do {
            try pipeline.run()
            XCTAssertEqual(step.numRuns, 1)
        } catch {
            XCTFail("Should not throw.")
        }
    }

    func testRunIsCalledMultipleTimes() {
        let pipeline = StepPipeline(steps: [step, step, step], context: context)
        do {
            try pipeline.run()
            XCTAssertEqual(step.numRuns, 3)
        } catch {
            XCTFail("Should not throw.")
        }
    }

    func testFailureIsReturnedOnAnException() {
        let step = MockThrowingStep()
        let pipeline = StepPipeline(steps: [step], context: context)
        do {
            try pipeline.run()
            XCTFail("Should not succeed.")
        } catch {
            XCTAssert(true)
        }
    }

    func testCaseSensitivityDifferenceBetweenXcodeAndFileSystem() {
        let fileFolder = #file.split(separator: "/").dropLast(2).joined(separator: "/")
        let path = "/" + fileFolder.appending("/Fixtures/CaseSensitivity/")
        let steps: [Step] = [FileGatherStep(), XcodeReferenceGatherStep(), UnusedFileAnalyzerStep()]
        let context = StepPipelineContext(verbose: false, extensions: [".swift"], path: path)
        let pipeline = StepPipeline(steps: steps, context: context)
        do {
            try pipeline.run()
            print("UnusedFiles: \(context.unusedFiles)")
            XCTAssert(context.unusedFiles.all.isEmpty)
        } catch {
            XCTFail("Should not throw.")
        }
    }
}
