//
//  VersionCommand.swift
//  xcutility
//
//  Created by Jeff Lett on 2/15/19.
//

import Commandant
import Foundation
import Result
import XCUtilityFramework

struct VersionCommand: CommandProtocol {
    // MARK: - CommandProtocol

    let verb = "version"
    let function = "Display the current version of xcutility"

    func run(_ options: NoOptions<CommandantError<()>>) -> Result<(), CommandantError<()>> {
        print(Version.current.value)
        return .success(())
    }
}
