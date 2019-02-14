//
//  XcodeReferenceGatherStepTests.swift
//  XcodeMissingFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

import PathKit
@testable import XcodeMissingFramework
import XCTest

class XcodeReferenceGatherStepTests: XCTestCase {
    let simpleProjectPathString = "/" + #file.split(separator: "/").dropLast(2).joined(separator: "/").appending("/Fixtures/SimpleProject/")
    let invalidProjectPathString = "/" + #file.split(separator: "/").dropLast(2).joined(separator: "/").appending("/Fixtures/InvalidProject/")
    var simpleProjectPath: Path!
    var invalidProjectPath: Path!

    override func setUp() {
        super.setUp()
        simpleProjectPath = Path(simpleProjectPathString)
        invalidProjectPath = Path(invalidProjectPathString)
    }

    func testAllReferencesAreGatheredFromSimpleProject() {
        let testPaths = [simpleProjectPathString + "SimpleProject/AppDelegate.swift", simpleProjectPathString + "SimpleProject/ViewController.swift", simpleProjectPathString + "SimpleProject/Info.plist"]
        let context = StepPipelineContext(verbose: true, extensions: [], path: simpleProjectPath)
        let xcodeRefStep = XcodeReferenceGatherStep()
        for testPath in testPaths {
            context.files[testPath] = 0
        }

        do {
            try xcodeRefStep.run(context: context)
            XCTAssertEqual(context.xcodeProjects.count, 1)
            for testPath in testPaths {
                XCTAssertEqual(context.files[testPath], 1)
            }
        } catch {
            XCTFail()
        }
    }

    func testExceptionIsThrownWhenGivenABadPath() {
        let path = Path("ksjdhf")
        let xcodeRefStep = XcodeReferenceGatherStep()
        let context = StepPipelineContext(verbose: false, extensions: [], path: path)
        do {
            try xcodeRefStep.run(context: context)
            XCTFail()
        } catch {
            XCTAssert(true)
        }
    }

//    func testNoExceptionIsThrownForInvalidProject() {
//        let xcodeRefStep = XcodeReferenceGatherStep()
//        let context = StepPipelineContext(verbose: true, extensions: [], path: invalidProjectPath)
//        do {
//            try xcodeRefStep.run(context: context)
//            XCTAssert(true)
//        } catch {
//            XCTFail()
//        }
//    }
}
