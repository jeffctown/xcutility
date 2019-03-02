//
//  FindXcodeFilesTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

import PathKit
import XCTest
@testable import XCUtilityFramework

// swiftlint:disable implicitly_unwrapped_optional
class FindXcodeFilesTests: XCTestCase {
    var config: Configuration!

    override func setUp() {
        super.setUp()
        config = Configuration(excluded: [],
                               extensions: [],
                               verbose: false,
                               path: Fixtures.fixtureSimpleProjectPath)
    }

    func testAllReferencesAreGatheredFromSimpleProject() {
        let context = PipelineState(config: config)
        if let xcodeProj = XcodeProject(path: Fixtures.fixtureSimpleProject) {
            context.xcodeProjects.append(xcodeProj)
        }
        XCTAssertEqual(context.xcodeProjects.count, 1)
        let xcodeRefStep = FindXcodeFiles()
        do {
            try xcodeRefStep.run(context: context)
            XCTAssertEqual(context.xcodeProjects.count, 1)
            XCTAssertEqual(context.xcodeProjects.first?.files.count, 3)
        } catch {
            XCTFail("No Exception Expected.")
        }
    }

    func testOnlyReferencesWithExtensionsAreGatheredFromSimpleProject() {
        config = Configuration(excluded: [],
                               extensions: [".swift"],
                               verbose: false,
                               path: Fixtures.fixtureSimpleProjectPath)
        let context = PipelineState(config: config)
        if let xcodeProj = XcodeProject(path: Fixtures.fixtureSimpleProject) {
            context.xcodeProjects.append(xcodeProj)
        }
        XCTAssertEqual(context.xcodeProjects.count, 1)
        let xcodeRefStep = FindXcodeFiles()

        do {
            try xcodeRefStep.run(context: context)
            XCTAssertEqual(context.xcodeProjects.count, 1)
            XCTAssertEqual(context.xcodeProjects.first?.files.count, 2)
            for xcodeFile in context.xcodeProjects.first?.files ?? [] {
                XCTAssertTrue(xcodeFile.path.string.hasSuffix(".swift"))
            }
        } catch {
            XCTFail("No Exception Expected.")
        }
    }

    func testOnlyReferencesWithMultipleExtensionsAreGatheredFromSimpleProject() {
        config = Configuration(excluded: [],
                               extensions: [".swift", ".plist"],
                               verbose: false,
                               path: Fixtures.fixtureSimpleProjectPath)
        let context = PipelineState(config: config)
        if let xcodeProj = XcodeProject(path: Fixtures.fixtureSimpleProject) {
            context.xcodeProjects.append(xcodeProj)
        }
        XCTAssertEqual(context.xcodeProjects.count, 1)
        let xcodeRefStep = FindXcodeFiles()

        do {
            try xcodeRefStep.run(context: context)
            XCTAssertEqual(context.xcodeProjects.count, 1)
            XCTAssertEqual(context.xcodeProjects.first?.files.count, 3)
            for xcodeFile in context.xcodeProjects.first?.files ?? [] {
                XCTAssertTrue(xcodeFile.path.string.hasSuffix(".swift") || xcodeFile.path.string.hasSuffix(".plist"))
            }
        } catch {
            XCTFail("No Exception Expected.")
        }
    }
}
