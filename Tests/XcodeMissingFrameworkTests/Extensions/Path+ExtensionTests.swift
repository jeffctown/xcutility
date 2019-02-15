// swiftlint:disable:this file_name
//  PathExtensionTests.swift
//  xcodemissingTests
//
//  Created by Jeff Lett on 2/12/19.
//

import PathKit
import XcodeMissingFramework
import XCTest

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
        let context = StepPipelineContext(verbose: false, extensions: [], path: "")
        XCTAssertFalse(Path("/Users/user/repo/project.xcodeproj").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/project.xcworkspace").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/Images.xcassets/image.png").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/BadassPod.podspec").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/.gitignore").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/.DS_Store").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/fastlane").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/.git").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/Carthage").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/AFNetworking.framework").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/Podfile").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/Podfile.lock").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/Gemfile").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/thing.playground").isStaticallyValid(context: context))
        XCTAssertFalse(Path("/Users/user/repo/.idea/").isStaticallyValid(context: context))
    }

    func testThatValidExtensionIsWorkingWithNoOption() {
        let context = StepPipelineContext(verbose: false, extensions: [], path: "")
        XCTAssert(Path("/Users/user/repo/File.swift").isValidExtension(context: context))
        XCTAssert(Path("/Users/user/repo/File.h").isValidExtension(context: context))
        XCTAssert(Path("/Users/user/repo/File.m").isValidExtension(context: context))
    }

    func testThatValidExtensionsIsWorkingWithExtensionsOption() {
        let context = StepPipelineContext(verbose: false, extensions: [".h", ".m", ".swift"], path: "")
        XCTAssert(Path("/Users/user/repo/File.swift").isValidExtension(context: context))
        XCTAssert(Path("/Users/user/repo/File.h").isValidExtension(context: context))
        XCTAssert(Path("/Users/user/repo/File.m").isValidExtension(context: context))
        XCTAssertFalse(Path("/Users/user/repo/File").isValidExtension(context: context))
        XCTAssertFalse(Path("/Users/user/repo/File.m.swif").isValidExtension(context: context))
        XCTAssertFalse(Path("/Users/user/repo/File.md").isValidExtension(context: context))
    }
}
