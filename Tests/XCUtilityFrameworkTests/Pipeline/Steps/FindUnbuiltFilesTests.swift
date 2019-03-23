//
//  FindUnbuiltFilesTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/2/19.
//

import PathKit
import XCTest
@testable import XCUtilityFramework

class FindUnbuiltFilesTests: XCTestCase {
    func testUnusedFilesAreFound() {
        let testStep = FindUnbuiltFiles()
        let config = Configuration(excluded: [],
                                   extensions: [],
                                   verbose: false,
                                   path: Fixtures.fixtureSimpleProject)
        let state = PipelineState(config: config)
        let builtFileString = "builtFile"
        let builtFile = XcodeFile(fileReference: nil, path: Path(builtFileString))
        let unbuiltFileString = "unbuiltFile"
        let unbuiltFile = XcodeFile(fileReference: nil, path: Path(unbuiltFileString))
        state.xcodeProjects.append(XcodeProject(path: Fixtures.fixtureSimpleProject)!)
        XCTAssertEqual(state.xcodeProjects.count, 1)
        state.xcodeProjects.first?.sourceBuildFiles.append(unbuiltFileString)
        state.xcodeProjects.first?.files.append(builtFile)
        state.xcodeProjects.first?.files.append(unbuiltFile)
        do {
            try testStep.run(context: state)
            XCTAssertEqual(state.xcodeProjects.first?.unbuiltFiles.count, 1 )
        } catch {
            XCTFail("Exception not expected. \(error.localizedDescription)")
        }
    }
}
