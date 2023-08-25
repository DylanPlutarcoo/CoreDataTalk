//
//  TaskEntity+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by userext on 25/08/23.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?

}

extension TaskEntity : Identifiable {

}
