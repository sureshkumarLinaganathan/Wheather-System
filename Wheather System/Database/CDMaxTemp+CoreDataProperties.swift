//
//  CDMaxTemp+CoreDataProperties.swift
//  Wheather System
//
//  Created by Natarajan on 09/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//
//

import Foundation
import CoreData


extension CDMaxTemp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMaxTemp> {
        return NSFetchRequest<CDMaxTemp>(entityName: "CDMaxTemp")
    }

    @NSManaged public var value: Double
    @NSManaged public var year: Int64
    @NSManaged public var month: Int64
    @NSManaged public var countryName: String?

}
