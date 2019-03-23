//
//  StepFactory.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/14/19.
//

import Foundation

public protocol StepFactory {
    func steps(delete: Bool) -> [Step]
}

public struct AbstractStepFactory {
    public enum Command {
        case findAll, findUnbuilt, findUnreferenced
    }

    public static func stepFactory(for command: Command) -> StepFactory {
        switch command {
        case .findAll:
            return FindAllStepFactory()
        case .findUnbuilt:
            return FindUnbuiltStepFactory()
        case .findUnreferenced:
            return FindUnreferencedStepFactory()
        }
    }
}
