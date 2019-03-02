//
//  FindXcodeProjectsTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/2/19.
//

import XCTest
@testable import XCUtilityFramework

class FindXcodeProjectsTests: XCTestCase {
    func testExceptionIsThrownWhenGivenABadPath() {
        let testStep = FindXcodeProjects()
        let config = Configuration(excluded: [],
                                   extensions: [],
                                   verbose: false,
                                   path: "ksjdhf")
        let context = PipelineState(config: config)
        do {
            try testStep.run(context: context)
            XCTFail("Exception Expected.")
        } catch {
            XCTAssert(true)
        }
    }

    func testSimpleProjectIsFoundWhenSearchingDirectory() {
        let testStep = FindXcodeProjects()
        let config = Configuration(excluded: [],
                                   extensions: [],
                                   verbose: false,
                                   path: Fixtures.fixtureSimpleProjectPath)
        let context = PipelineState(config: config)
        do {
            try testStep.run(context: context)
            XCTAssertEqual(context.xcodeProjects.count, 1)
        } catch {
            XCTFail("Exception not expected. \(error.localizedDescription)")
        }
    }

    func testFixtureProjectsAreFound() {
        let testStep = FindXcodeProjects()
        let config = Configuration(excluded: [],
                                   extensions: [],
                                   verbose: false,
                                   path: Fixtures.fixturesFolder)
        let context = PipelineState(config: config)
        do {
            try testStep.run(context: context)
            XCTAssertEqual(context.xcodeProjects.count, 2)
        } catch {
            Log.shared.log(Fixtures.fixturesFolder)
            XCTFail("Exception not expected. \(error.localizedDescription)")
        }
    }

    func testXcodeProjectCanBeExcluded() {
        let testStep = FindXcodeProjects()
        let config = Configuration(excluded: ["SimpleProject"],
                                   extensions: [],
                                   verbose: false,
                                   path: Fixtures.fixturesFolder)
        let context = PipelineState(config: config)
        do {
            try testStep.run(context: context)
            XCTAssertEqual(context.xcodeProjects.count, 1)
        } catch {
            XCTFail("Exception not expected. \(error.localizedDescription)")
        }
    }

    func testMultipleXcodeProjectsCanBeExcluded() {
        let testStep = FindXcodeProjects()
        let config = Configuration(excluded: [".xcodeproj"],
                                   extensions: [],
                                   verbose: true,
                                   path: Fixtures.fixturesFolder)
        let context = PipelineState(config: config)
        do {
            try testStep.run(context: context)
            XCTAssertEqual(context.xcodeProjects.count, 0)
        } catch {
            XCTFail("Exception not expected. \(error.localizedDescription)")
        }
    }

    func testInvalidXcodeProjectsFailsSilently() {
        let testStep = FindXcodeProjects()
        let config = Configuration(excluded: [],
                                   extensions: [],
                                   verbose: true,
                                   path: Fixtures.fixtureInvalidProjectPath)
        let context = PipelineState(config: config)
        do {
            try testStep.run(context: context)
            XCTAssertEqual(context.xcodeProjects.count, 0)
        } catch {
            XCTFail("Exception not expected. \(error.localizedDescription)")
        }
    }
}
