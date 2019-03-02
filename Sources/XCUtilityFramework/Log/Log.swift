//
//  Log.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/10/19.
//

import Foundation

protocol LogAdapter {
    func log(_ item: Any)
}

struct Log {
    static let shared = Log()

    private init() {
        self.adapters.append(PrintLogAdapter())
    }

    var adapters = [LogAdapter]()

    func header(_ title: String) {
        print("""

************ \(title) ************

""")
    }

    func summary(_ title: String) {
        log("""

****** \(title) ******

""")
    }

    func log(_ message: Any) {
        adapters.forEach { $0.log(message) }
    }
}
