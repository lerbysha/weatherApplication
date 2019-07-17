//
//  City+CoreDataClass.swift
//  weatherApp
//
//  Created by Артур Гайсин on 17/07/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//
//

import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject, Codable {

    enum apiKey: String, CodingKey {
        case name, main, wind

    }

    enum nestedWindApiKey: String, CodingKey{
        case speed
        case deg
    }

    enum nestetMainApiKey: String, CodingKey{
        case temp

    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {

        ///Fetch context for codable
        guard let codableContext = CodingUserInfoKey.init(rawValue: "context"),
            let manageObjContext = decoder.userInfo[codableContext] as? NSManagedObjectContext,
            let manageObjList = NSEntityDescription.entity(forEntityName: "City", in: manageObjContext) else {
                fatalError("failed")
        }

        self.init(entity: manageObjList, insertInto: manageObjContext)

        let container = try decoder.container(keyedBy: apiKey.self)
        self.name = try container.decode(String.self, forKey: .name)

        let wind = try container.nestedContainer(keyedBy: nestedWindApiKey.self, forKey: .wind)
        self.speed = try wind.decode(Double.self, forKey: .speed)
        self.deg = try wind.decode(Double.self, forKey: .deg)


        let main = try container.nestedContainer(keyedBy: nestetMainApiKey.self, forKey: .main)
        self.temp = try main.decode(Double.self, forKey: .temp)
    }

    // MARK: - encode
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: apiKey.self)
        try container.encode(name, forKey: .name)

        var wind = container.nestedContainer(keyedBy: nestedWindApiKey.self, forKey: .wind)
        try wind.encode(speed, forKey: .speed)
        try wind.encode(deg, forKey: .deg)

        var main = container.nestedContainer(keyedBy: nestetMainApiKey.self, forKey: .main)
        try main.encode(temp, forKey: .temp)
    }

}
