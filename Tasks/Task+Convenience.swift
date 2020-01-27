//
//  Task+Convenience.swift
//  Tasks
//
//  Created by Aaron Cleveland on 1/27/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation
import CoreData

extension Task {

    convenience init(name: String, notes: String? = nil, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.notes = notes
    }
    
}
