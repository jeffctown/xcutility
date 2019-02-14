//
//  StepPipelineTests.swift
//  XcodeMissingFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

@testable import XcodeMissingFramework
import XCTest

class StepPipelineTests: XCTestCase {
    var step: MockStep!
    var options = Options(path: "", extensions: [], verbose: true)

    class MockStep: Step {
        var numRuns = 0
        func run(context: StepPipelineContext) throws {
            numRuns = numRuns + 1
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
        let pipeline = StepPipeline(steps: [step], options: options)
        let result = pipeline.run()
        XCTAssertEqual(step.numRuns, 1)
        switch result {
        case .success:
            XCTAssert(true)
        case .failure:
            XCTFail()
        }
    }

    func testRunIsCalledMultipleTimes() {
        let pipeline = StepPipeline(steps: [step, step, step], options: options)
        let result = pipeline.run()
        XCTAssertEqual(step.numRuns, 3)
        switch result {
        case .success:
            XCTAssert(true)
        case .failure:
            XCTFail()
        }
    }

    func testFailureIsReturnedOnAnException() {
        let step = MockThrowingStep()
        let pipeline = StepPipeline(steps: [step], options: options)
        let result = pipeline.run()
        switch result {
        case .success:
            XCTFail()
        case .failure:
            XCTAssert(true)
        }
    }
}
