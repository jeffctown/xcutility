//
//  YamlParserTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/11/19.
//

import Foundation
import XCTest
@testable import XCUtilityFramework

class YamlParserTests: XCTestCase {
    func testParserThrowsWhenGivenABadPath() {
        let validYaml = Fixtures.fixtureConfigPath + "not-there.yml"
        do {
            _ = try YamlParser.parse(validYaml)
            XCTFail("Excepted Expected for bad yaml path.")
        } catch YamlParser.YamlParserError.fileNotFound(let message) {
            XCTAssertNotNil(message)
        } catch {
            XCTFail("File not found exception expected.")
        }
    }

    func testParserThrowsWhenGivenFileWithInvalidFormat() {
        let invalidYaml = Fixtures.fixtureConfigPath + "invalid.yml"
        do {
            _ = try YamlParser.parse(invalidYaml)
            XCTFail("Excepted Expected for bad yaml format.")
        } catch YamlParser.YamlParserError.yamlParsing(let message) {
            XCTAssertNotNil(message)
        } catch {
            XCTFail("Parsing exception expected.")
        }
    }

    func testParserReturnsValidYaml() {
        let validYaml = Fixtures.fixtureConfigPath + "simple.yml"
        do {
            let output = try YamlParser.parse(validYaml)
            XCTAssertNotNil(output["excluded"])
            XCTAssertNotNil(output["xcodetools_version"])
        } catch {
            XCTFail("Parsing exception expected.")
        }
    }

    func testParserReturnsWhenGivenEmptyYaml() {
        let emptyYaml = Fixtures.fixtureConfigPath + "empty.yml"
        do {
            let output = try YamlParser.parse(emptyYaml)
            XCTAssertNotNil(output)
        } catch {
            XCTFail("Parsing exception expected.")
        }
    }
}
