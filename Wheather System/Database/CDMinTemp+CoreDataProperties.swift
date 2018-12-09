//
//  CDMinTemp+CoreDataProperties.swift
//  Wheather System
//
//  Created by Natarajan on 09/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//
//

import Foundation
import CoreData


extension CDMinTemp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMinTemp> {
        return NSFetchRequest<CDMinTemp>(entityName: "CDMinTemp")
    }

    @NSManaged public var value: Double
    @NSManaged public var month: Int64
    @NSManaged public var year: Int64
    @NSManaged public var countryName: String?

}
