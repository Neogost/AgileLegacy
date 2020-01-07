//
//  Workshop+CoreDataProperties.swift
//  AgileLegacy
//
//  Created by Kevin Desmay on 18/09/2019.
//  Copyright © 2019 Kevin Desmay. All rights reserved.
//
//

import Foundation
import CoreData


extension Workshop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workshop> {
        return NSFetchRequest<Workshop>(entityName: "Workshop")
    }

    @NSManaged public var archived: Bool
    @NSManaged public var detail: String?
    @NSManaged public var difficulty: Int16
    @NSManaged public var durationMax: Int16
    @NSManaged public var durationMin: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var nbPeopleMax: Int16
    @NSManaged public var nbPeopleMin: Int16
    @NSManaged public var resume: String?
    @NSManaged public var source: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var materialList: String?

}

// MARK: Generated accessors for materialList
extension Workshop {

    
}
