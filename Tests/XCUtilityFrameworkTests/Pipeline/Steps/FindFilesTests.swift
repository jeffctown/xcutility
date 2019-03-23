//
//  FindFilesTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

import XCTest
@testable import XCUtilityFramework

// swiftlint:disable force_try implicitly_unwrapped_optional
final class FindFilesTests: XCTestCase {
    let folderPath = NSTemporaryDirectory() + "FileGatherTests"
    var config: Configuration!

    override func setUp() {
        super.setUp()
        let folderURL = URL(fileURLWithPath: folderPath)
        self.config = Configuration(excluded: [],
                                    extensions: [],
                                    verbose: true,
                                    path: folderPath)
        try? FileManager.default.removeItem(at: folderURL)
        try! FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        FileManager.default.createFile(atPath: folderPath + "/File.swift", contents: nil)
        FileManager.default.createFile(atPath: folderPath + "/AnotherFile.h", contents: nil)
        FileManager.default.createFile(atPath: folderPath + "/AnotherFile.m", contents: nil)
        FileManager.default.createFile(atPath: folderPath + "/AnotherFile.txt", contents: nil)
    }

    func testExceptionIsThrownWithBadPath() {
        let config = Configuration(excluded: [],
                                   extensions: [],
                                   verbose: false,
                                   path: "khadsdhh")
        let context = PipelineState(config: config)
        do {
            try FindFiles().run(context: context)
            XCTFail("Exception should be thrown for a bad path.")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testAllFilesAreGatheredWithNoExtensions() {
        let context = PipelineState(config: config)
        do {
            try FindFiles().run(context: context)
            XCTAssertEqual(context.files.all.count, 4)
        } catch {
            XCTFail("Should not throw.")
        }
    }

    func testAllFilesAreGatheredWhenVerbose() {
        let context = PipelineState(config: config)
        do {
            try FindFiles().run(context: context)
            XCTAssertEqual(context.files.all.count, 4)
            for file in context.files.all {
                XCTAssert(!file.hasProjectReferences)
            }
        } catch {
            XCTFail("Should not throw.")
        }
    }

    func testAllFilesAreGatheredWhenOneExtensionIsUsed() {
        self.config = Configuration(excluded: [],
                                    extensions: [".swift"],
                                    verbose: true,
                                    path: folderPath)
        let context = PipelineState(config: config)
        do {
            try FindFiles().run(context: context)
            XCTAssertEqual(context.files.all.count, 1)
            for file in context.files.all {
                XCTAssert(!file.hasProjectReferences)
            }
        } catch {
            XCTFail("Should not throw.")
        }
    }

    func testAllFilesAreGatheredWhenMultipleExtensionsAreUsed() {
        self.config = Configuration(excluded: [],
                                    extensions: [".swift", ".h", ".m"],
                                    verbose: true,
                                    path: folderPath)
        let context = PipelineState(config: config)
        do {
            try FindFiles().run(context: context)
            XCTAssertEqual(context.files.all.count, 3)
            for file in context.files.all {
                XCTAssert(!file.hasProjectReferences)
            }
        } catch {
            XCTFail("Should not throw.")
        }
    }
}
