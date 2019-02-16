//
//  XcodeReferenceGatherStepTests.swift
//  XcodeMissingFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

@testable import XcodeMissingFramework
import XCTest

class XcodeReferenceGatherStepTests: XCTestCase {
    static let fileFolder = #file.split(separator: "/").dropLast(2).joined(separator: "/")
    static let simpleProjectPathString = "/" + fileFolder.appending("/Fixtures/SimpleProject/")
    static let invalidProjectPathString = "/" + fileFolder.appending("/Fixtures/InvalidProject/")

    override func setUp() {
        super.setUp()
    }

    func testAllReferencesAreGatheredFromSimpleProject() {
        let testPaths = [
            XcodeReferenceGatherStepTests.simpleProjectPathString + "SimpleProject/AppDelegate.swift",
            XcodeReferenceGatherStepTests.simpleProjectPathString + "SimpleProject/ViewController.swift",
            XcodeReferenceGatherStepTests.simpleProjectPathString + "SimpleProject/Info.plist"
        ]
        let path = XcodeReferenceGatherStepTests.simpleProjectPathString
        let context = StepPipelineContext(verbose: true, extensions: [], path: path)
        let xcodeRefStep = XcodeReferenceGatherStep()
        for testPath in testPaths {
            context.files.add(File(filename: testPath))
        }

        do {
            try xcodeRefStep.run(context: context)
            XCTAssertEqual(context.xcodeProjects.count, 1)
            for testPath in testPaths {
                XCTAssert(context.files.file(for: testPath)!.isUsed, "\(testPath) must show as referenced by Xcode.")
            }
        } catch {
            XCTFail("No Exception Expected.")
        }
    }

    func testExceptionIsThrownWhenGivenABadPath() {
        let xcodeRefStep = XcodeReferenceGatherStep()
        let context = StepPipelineContext(verbose: false, extensions: [], path: "ksjdhf")
        do {
            try xcodeRefStep.run(context: context)
            XCTFail("Exception Expected.")
        } catch {
            XCTAssert(true)
        }
    }

    func testNoExceptionIsThrownForInvalidProject() {
        let xcodeRefStep = XcodeReferenceGatherStep()
        let path = XcodeReferenceGatherStepTests.invalidProjectPathString
        let context = StepPipelineContext(verbose: true, extensions: [], path: path)
        do {
            try xcodeRefStep.run(context: context)
            XCTAssert(true)
        } catch {
            XCTFail("Should not throw.")
        }
    }
}
