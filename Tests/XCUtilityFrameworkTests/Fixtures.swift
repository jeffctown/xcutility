//
//  Fixtures.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 3/4/19.
//

import Foundation

class Fixtures {
    static let fixturesFolder = "/" + #file.split(separator: "/").dropLast(2).joined(separator: "/") + "/Fixtures/"
    static let fixtureSimpleProjectPath = fixturesFolder.appending("SimpleProject/")
    static let fixtureSimpleProject = fixtureSimpleProjectPath + "SimpleProject.xcodeproj"
    static let fixtureCaseSensitivityPath = fixturesFolder.appending("CaseSensitivity/")
    static let fixtureInvalidProjectPath = fixturesFolder.appending("InvalidProject/")
    static let fixtureConfigPath = fixturesFolder.appending("Configs/")
    static let fixtureConfigSimplePath = fixtureConfigPath.appending("simple.yml")
    static let fixtureConfigEmptyPath = fixtureConfigPath.appending("empty.yml")
    static let fixtureConfigInvalidPath = fixtureConfigPath.appending("invalid.yml")
}
