//
//  VersionCommand.swift
//  XcodeMissingFramework
//
//  Created by Jeff Lett on 2/15/19.
//

import Foundation
import Commandant
import Result
import XcodeMissingFramework

public struct VersionCommand: CommandProtocol {
    public let verb = "version"
    public let function = "Display the current version of XcodeMissing"
    
    public init() {}
    
    public func run(_ options: NoOptions<CommandantError<()>>) -> Result<(), CommandantError<()>> {
        print(Version.current.value)
        return .success(())
    }
    
}
