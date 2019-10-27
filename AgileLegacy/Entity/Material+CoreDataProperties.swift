//
//  Material+CoreDataProperties.swift
//  AgileLegacy
//
//  Created by Kevin Desmay on 18/09/2019.
//  Copyright © 2019 Kevin Desmay. All rights reserved.
//
//

import Foundation
import CoreData


extension Material {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Material> {
        return NSFetchRequest<Material>(entityName: "Material")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}
