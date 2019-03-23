//
//  DeleteUnbuiltFilesTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/11/19.
//

import Foundation
import PathKit
import xcodeproj
import XCTest
@testable import XCUtilityFramework

// swiftlint:disable implicitly_unwrapped_optional force_try
class DeleteUnbuiltFilesTests: XCTestCase {
    let folderPath = NSTemporaryDirectory() + "DeleteUnbuiltFileTests"
    var testPath: String!
    var swiftFilePath: String!
    var objCHeaderPath: String!
    var objCImplPath: String!
    var otherFilePath: String!
    var xcodePathString: String!
    var xcodePath: Path!
    var testXcodeProject: XcodeProject!
    var testXcodeProjectPath: String!

    override func setUp() {
        super.setUp()
        testPath = folderPath + "/SimpleProject"
        testXcodeProjectPath = testPath + "/SimpleProject.xcodeproj"
        try? FileManager.default.removeItem(atPath: folderPath)
        try! FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true)
        try! FileManager.default.copyItem(atPath: Fixtures.fixtureSimpleProjectPath, toPath: testPath)
        testXcodeProject = XcodeProject(path: testXcodeProjectPath)
    }

    func testDeletingUnbuiltFiles() {
        let testStep = DeleteUnbuiltFiles()
        let config = Configuration(excluded: [], extensions: [], verbose: true, path: testPath)
        let context = PipelineState(config: config)
        context.xcodeProjects.append(testXcodeProject)
        testXcodeProject.loadFiles(context: context)
        XCTAssertEqual(testXcodeProject.files.count, 3)
        if let firstFile = testXcodeProject.files.first {
            XCTAssertNotNil(firstFile)
            testXcodeProject.unbuiltFiles.append(firstFile)
        } else {
            XCTFail("Files Expected.")
        }
        try! testStep.run(context: context)
        try! testXcodeProject.save()
        testXcodeProject = XcodeProject(path: testXcodeProjectPath)
        testXcodeProject.loadFiles(context: context)
        XCTAssertEqual(testXcodeProject.files.count, 2)
    }
}
