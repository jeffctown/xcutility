// swiftlint:disable:this file_name
//  PathExtensionTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 2/12/19.
//

import PathKit
import XCTest
@testable import XCUtilityFramework

final class PathExtensionsTests: XCTestCase {
    func testThatPathKnowsWhenItIsAnXcodeProject() {
        let xcodeprojPath = Path("/Users/user/repo/project.xcodeproj")
        XCTAssert(xcodeprojPath.isXcodeProject)

        let relativeXcodeprojPath = Path("./Sweetapp.xcodeproj")
        XCTAssert(relativeXcodeprojPath.isXcodeProject)

        let insideXcodeprojPath = Path("/Users/user/repo/project.xcodeproj/project.pbxproj")
        XCTAssertFalse(insideXcodeprojPath.isXcodeProject)
    }

    func testThatRecursivelyFilterFilters() {
        let filtered = try? Path(FileManager.default.currentDirectoryPath).recursiveFilter { _ -> Bool in
            false
        }
        XCTAssert(filtered != nil)
        XCTAssert(filtered!.isEmpty)
    }

    func testThatInvalidPathsAreInvalid() {
        let config = Configuration(excluded: [".xcodeproj",
                                              ".xcworkspace",
                                              "png",
                                              ".podspec",
                                              ".gitignore",
                                              ".DS_Store",
                                              "fastlane",
                                              ".git",
                                              "Carthage",
                                              ".framework",
                                              "Podfile",
                                              "Gemfile",
                                              ".playground",
                                              ".idea"],
                                   extensions: [],
                                   verbose: false,
                                   path: "")
        let context = PipelineState(config: config)
        XCTAssertFalse(Path("/Users/user/repo/project.xcodeproj").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/project.xcworkspace").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/Images.xcassets/image.png").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/BadassPod.podspec").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/.gitignore").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/.DS_Store").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/fastlane").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/.git").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/Carthage").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/AFNetworking.framework").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/Podfile").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/Podfile.lock").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/Gemfile").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/thing.playground").isValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/.idea/").isValid(context: context))
    }

    func testThatValidExtensionIsWorkingWithNoOption() {
        let config = Configuration(excluded: [],
                                   extensions: [],
                                   verbose: false,
                                   path: "")
        let context = PipelineState(config: config)
        XCTAssert(Path("/Users/user/repo/File.swift").isValidExtension(context: context))
        XCTAssert(Path("/Users/user/repo/File.h").isValidExtension(context: context))
        XCTAssert(Path("/Users/user/repo/File.m").isValidExtension(context: context))
    }

    func testThatValidExtensionsIsWorkingWithExtensionsOption() {
        let config = Configuration(excluded: [],
                                   extensions: [".h", ".m", ".swift"],
                                   verbose: false,
                                   path: "")
        let context = PipelineState(config: config)
        XCTAssert(Path("/Users/user/repo/File.swift").isValidExtension(context: context))
        XCTAssert(Path("/Users/user/repo/File.h").isValidExtension(context: context))
        XCTAssert(Path("/Users/user/repo/File.m").isValidExtension(context: context))
        XCTAssertFalse(Path("/Users/user/repo/File").isValidExtension(context: context))
        XCTAssertFalse(Path("/Users/user/repo/File.m.swif").isValidExtension(context: context))
        XCTAssertFalse(Path("/Users/user/repo/File.md").isValidExtension(context: context))
    }
}
