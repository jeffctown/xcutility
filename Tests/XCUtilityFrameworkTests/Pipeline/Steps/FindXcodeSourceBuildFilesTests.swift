//
//  FindXcodeSourceBuildFilesTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/4/19.
//

import XCTest
@testable import XCUtilityFramework

class FindXcodeSourceBuildFilesTests: XCTestCase {
    func testSourceBuildFilesAreGatheredInSimpleProject() {
        let testStep = FindXcodeSourceBuildFiles()
        let config = Configuration(excluded: [],
                                   extensions: [],
                                   verbose: false,
                                   path: Fixtures.fixtureSimpleProject)
        let state = PipelineState(config: config)
        do {
            guard let xcodeProject = XcodeProject(path: state.config.path) else {
                XCTFail("XcodeProject should be returned.")
                return
            }

            state.xcodeProjects.append(xcodeProject)
            try testStep.run(context: state)
            XCTAssertEqual(state.xcodeProjects.first?.sourceBuildFiles.count, 2)
        } catch {
            XCTFail("Exception not expected. \(error.localizedDescription)")
        }
    }
}
