//
//  City+CoreDataProperties.swift
//  weatherApp
//
//  Created by Артур Гайсин on 17/07/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var deg: Double
    @NSManaged public var name: String?
    @NSManaged public var speed: Double
    @NSManaged public var temp: Double

}
