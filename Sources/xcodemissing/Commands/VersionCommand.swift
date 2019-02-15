//
//  VersionCommand.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/15/19.
//

import Foundation
import Commandant
import Result
import XcodeMissingFramework

struct VersionCommand: CommandProtocol {
    let verb = "version"
    let function = "Display the current version of xcodemissing"
    
    func run(_ options: NoOptions<CommandantError<()>>) -> Result<(), CommandantError<()>> {
        print(Version.current.value)
        return .success(())
    }
    
}
