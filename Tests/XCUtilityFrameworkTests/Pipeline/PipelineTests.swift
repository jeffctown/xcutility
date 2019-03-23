//
//  PipelineTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

import XCTest
@testable import XCUtilityFramework

// swiftlint:disable implicitly_unwrapped_optional
class PipelineTests: XCTestCase {
    var step: MockStep!
    var config: Configuration!
    var context: PipelineState!

    class MockStep: Step {
        var numRuns = 0

        func run(context: PipelineState) throws {
            numRuns += 1
        }
    }

    enum MockError: Error {
        case mockError
    }

    class MockThrowingStep: Step {
        func run(context: PipelineState) throws {
            throw MockError.mockError
        }
    }

    override func setUp() {
        super.setUp()
        self.step = MockStep()
        self.config = Configuration(excluded: [], extensions: [], verbose: false, path: "")
        self.context = PipelineState(config: config)
    }

    func testRunIsCalledOnStep() {
        var pipeline = Pipeline(steps: [step], context: context)
        do {
            try pipeline.run()
            XCTAssertEqual(step.numRuns, 1)
        } catch {
            XCTFail("Should not throw.")
        }
    }

    func testRunIsCalledMultipleTimes() {
        var pipeline = Pipeline(steps: [step, step, step], context: context)
        do {
            try pipeline.run()
            XCTAssertEqual(step.numRuns, 3)
        } catch {
            XCTFail("Should not throw.")
        }
    }

    func testFailureIsReturnedOnAnException() {
        let step = MockThrowingStep()
        var pipeline = Pipeline(steps: [step], context: context)
        do {
            try pipeline.run()
            XCTFail("Should not succeed.")
        } catch {
            XCTAssert(true)
        }
    }

    func testCaseSensitivityDifferenceBetweenXcodeAndFileSystem() {
        let fileFolder = #file.split(separator: "/").dropLast(3).joined(separator: "/")
        let path = "/" + fileFolder.appending("/Fixtures/CaseSensitivity/")
        let steps: [Step] = [FindFiles(),
                             FindXcodeProjects(),
                             FindXcodeFiles(),
                             FindXcodeReferences(),
                             FindUnreferencedFiles()]
        let config = Configuration(excluded: [],
                                   extensions: [".swift"],
                                   verbose: true,
                                   path: path)
        let context = PipelineState(config: config)
        var pipeline = Pipeline(steps: steps, context: context)
        do {
            try pipeline.run()
            XCTAssert(context.unreferencedFiles.all.isEmpty)
        } catch {
            XCTFail("Should not throw.")
        }
    }

    func testPerformanceOfCaseSensitivityFixture() {
        let fileFolder = #file.split(separator: "/").dropLast(3).joined(separator: "/")
        let path = "/" + fileFolder.appending("/Fixtures/CaseSensitivity/")
        let steps: [Step] = [FindFiles(),
                             FindXcodeProjects(),
                             FindXcodeFiles(),
                             FindXcodeReferences(),
                             FindUnreferencedFiles()]
        let config = Configuration(excluded: [],
                                   extensions: [".swift"],
                                   verbose: false,
                                   path: path)
        let context = PipelineState(config: config)
        var pipeline = Pipeline(steps: steps, context: context)
        self.measure {
            do {
                try pipeline.run()
                XCTAssert(context.unreferencedFiles.all.isEmpty)
            } catch {
                XCTFail("Should not throw.")
            }
        }
    }

    func testPerformanceOfSimpleFixture() {
        let fileFolder = #file.split(separator: "/").dropLast(3).joined(separator: "/")
        let path = "/" + fileFolder.appending("/Fixtures/SimpleProject/")
        let steps: [Step] = [FindFiles(),
                             FindXcodeProjects(),
                             FindXcodeFiles(),
                             FindXcodeReferences(),
                             FindUnreferencedFiles()]
        let config = Configuration(excluded: [],
                                   extensions: [".swift"],
                                   verbose: false,
                                   path: path)
        let context = PipelineState(config: config)
        var pipeline = Pipeline(steps: steps, context: context)
        self.measure {
            do {
                try pipeline.run()
                XCTAssert(context.unreferencedFiles.all.isEmpty)
            } catch {
                XCTFail("Should not throw.")
            }
        }
    }
}
