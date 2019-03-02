//
//  FindXcodeReferencesTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/2/19.
//

import PathKit
import XCTest
@testable import XCUtilityFramework

class FindXcodeReferencesTests: XCTestCase {
    func testThatThing() {
        let testStep = FindXcodeReferences()
        do {
            let config = Configuration(excluded: [],
                                       extensions: [],
                                       verbose: true,
                                       path: Fixtures.fixtureSimpleProject)
            let state = PipelineState(config: config)
            state.xcodeProjects.append(XcodeProject(path: Fixtures.fixtureSimpleProject)!)
            let usedFilePathString = "used"
            let usedFilePath = Path(usedFilePathString)
            let usedXcodeFile = XcodeFile(fileReference: nil, path: Path(usedFilePathString))
            let usedFile = File(filename: usedFilePathString)

            let unusedFilePathString = "unused"
            let unusedFilePath = Path(unusedFilePathString)
            let unusedFile = File(filename: unusedFilePathString)

            state.files.add(unusedFile)
            state.files.add(usedFile)
            state.xcodeProjects.first?.files.append(usedXcodeFile)
            try testStep.run(context: state)
            XCTAssertEqual(state.xcodeProjects.first?.files.count, 1)
            XCTAssertEqual(state.files.all.count, 2)
            let usedFileResult = state.files.file(for: usedFilePath)!
            XCTAssertTrue(usedFileResult.hasProjectReferences)
            let unusedFileResult = state.files.file(for: unusedFilePath)!
            XCTAssertFalse(unusedFileResult.hasProjectReferences)
        } catch {
            XCTFail("Exception not expected. \(error.localizedDescription)")
        }
    }
}
