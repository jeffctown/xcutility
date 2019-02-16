//
//  File.swift
//  XcodeMissingFramework
//
//  Created by Jeff Lett on 2/15/19.
//

import Foundation

struct File {

    let filename: String
    private var refCount: Int

    init(filename: String, referenceCount: Int = 0) {
        self.filename = filename
        self.refCount = referenceCount
    }

    mutating func incrementReferenceCount() {
        self.refCount += 1
    }

    var isUsed: Bool {
        return self.refCount > 0
    }
}

extension File: Comparable {
    static func < (lhs: File, rhs: File) -> Bool {
        return lhs.filename < rhs.filename
    }
}
