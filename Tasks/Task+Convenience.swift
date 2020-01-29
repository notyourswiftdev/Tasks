//
//  Task+Convenience.swift
//  Tasks
//
//  Created by Ben Gohlke on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

enum TaskPriority: String {
    case low
    case normal
    case high
    case critical
    
    static var allPriorities: [TaskPriority] {
        return [.low, .normal, .high, .critical]
    }
}

extension Task {
    convenience init(name: String,
                     notes: String? = nil,
                     priority: TaskPriority = .normal,
                     context: NSManagedObjectContext =
                        CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.priority = priority.rawValue
    }
}
