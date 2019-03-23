//
//  File.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 2/15/19.
//

import Foundation
import PathKit

struct File: CustomStringConvertible {
    let path: Path
    private let queue: DispatchQueue
    private var projectReferences: Int

    init(filename: String, referenceCount: Int = 0) {
        self.init(path: Path(filename), referenceCount: referenceCount)
    }

    init(path: Path, referenceCount: Int = 0) {
        self.path = path
        self.projectReferences = referenceCount
        self.queue = DispatchQueue(label: path.string)
    }

    mutating func incrementReferenceCount() {
        queue.sync { self.projectReferences += 1 }
    }

    var references: Int {
        return self.projectReferences
    }

    var hasProjectReferences: Bool {
        var hasProjectRefs: Bool = false
        queue.sync { hasProjectRefs = self.projectReferences > 0 }
        return hasProjectRefs
    }

    var description: String {
        return "\(path.string) \(projectReferences)"
    }
}

extension File: Comparable {
    static func < (lhs: File, rhs: File) -> Bool {
        return lhs.path < rhs.path
    }
}
