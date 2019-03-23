//
//  FindUnreferencedStepFactory.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/17/19.
//

import Foundation

struct FindUnreferencedStepFactory: StepFactory {
    func steps(delete: Bool) -> [Step] {
        var steps: [Step] = [
            FindFiles(),
            FindXcodeProjects(),
            FindXcodeFiles(),
            FindXcodeReferences(),
            FindUnreferencedFiles()
        ]

        if delete {
            steps.append(DeleteUnreferencedFiles())
        }

        return steps
    }
}
