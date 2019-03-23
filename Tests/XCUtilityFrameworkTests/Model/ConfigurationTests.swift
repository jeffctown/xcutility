//
//  ConfigurationTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/11/19.
//

import Foundation
import XCTest
@testable import XCUtilityFramework

// swiftlint:disable force_try
class ConfigurationTests: XCTestCase {
    func testSimpleConfigurationFileIsLoaded() {
        let configPath = Fixtures.fixtureConfigSimplePath
        let config = try! Configuration(configPath: configPath, extensions: [], verbose: true, path: "")
        XCTAssertEqual(config.excluded.count, 12)
    }

    func testConfigurationIsDefaultWhenGivenBadPath() {
        do {
            let config = try Configuration(configPath: "ksj", extensions: [], verbose: false, path: "")
            XCTAssertEqual(config.excluded, [])
            XCTAssertEqual(config.path, "")
            XCTAssertFalse(config.verbose)
        } catch {
            XCTFail("This should return a default configuration, not throw.")
        }
    }

    func testConfigurationLoadsAnEmptyFile() {
        let configPath = Fixtures.fixtureConfigEmptyPath
        let config = try! Configuration(configPath: configPath, extensions: [], verbose: true, path: "")
        XCTAssertNotNil(config)
    }

    func testConfigurationLoadsAnInvalidFile() {
        do {
            let configPath = Fixtures.fixtureConfigInvalidPath
            _ = try Configuration(configPath: configPath, extensions: [], verbose: false, path: "")
            XCTFail("Exception Expected")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    struct MockOptions: ConfigurationOptions {
        var extensions: [String]
        var verbose: Bool
        var path: String
        var config: String
        var delete: Bool
    }

    func testConfiguration() {
        let expectedExtensions = [".swift"]
        let expectedVerbose = true
        let expectedPath = "Path"
        let options = MockOptions(extensions: expectedExtensions,
                                  verbose: expectedVerbose,
                                  path: expectedPath,
                                  config: "Config",
                                  delete: false)
        let config = try! Configuration(options: options)
        XCTAssertEqual(config.extensions, expectedExtensions)
        XCTAssertEqual(config.verbose, expectedVerbose)
        XCTAssertEqual(config.path, expectedPath)
    }
}
