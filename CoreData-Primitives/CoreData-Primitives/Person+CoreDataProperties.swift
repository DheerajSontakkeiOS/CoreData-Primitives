//
//  Person+CoreDataProperties.swift
//  CoreData-Primitives
//
//  Created by MOBILE HUTT on 14/11/25.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var created: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var age: Int16
    @NSManaged public var salary: Double
    @NSManaged public var isActive: Bool

}

extension Person : Identifiable {

}
