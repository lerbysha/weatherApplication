//
//  WeatherGetter.swift
//  weatherApp
//
//  Created by Артур Гайсин on 17/07/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import Foundation
import UIKit
import CoreData


enum Result {
    case Success([City])
    case failure(error: Error)
}

class WeatherGetter {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var errorMessage = {(message : String) -> () in }
    
    fileprivate let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather"
    fileprivate let openWeatherMapAPIKey = "eb1fb13c08fcb4054fdb91693821c603"
    fileprivate let openWeatherMapUnits = "metric"
    
    func getWeather(city: String, completionBlock: @escaping (Result) -> ()) {
        
        guard let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?q=\(city)&units=\(openWeatherMapUnits)&appid=\(openWeatherMapAPIKey)") else { return }
        
        var request = URLRequest(url: weatherRequestURL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared

        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let jsonData = data else { return }
            DispatchQueue.main.async(execute: {
                
                guard let json = data else {
                    if let error = error {
                        completionBlock(.failure(error: error))
                    }
                    return
                }
                
                if let value = self.parseResponse(forData: jsonData, name: city) {
                    completionBlock(.Success(value))
                } else {
                    return
                }
            })
            
        }
        task.resume()
    }
    
    func parseResponse(forData jsonData : Data, name: String) -> [City]? {
        
        guard let codableContext = CodingUserInfoKey.init(rawValue: "context") else {
                fatalError("Failed context")
            }
        
        let manageObjContext = appDelegate.persistentContainer.viewContext
        let decoder = JSONDecoder()
        decoder.userInfo[codableContext] = manageObjContext
        
        guard var models: [City] = getAll(with: City.self) else { return nil }
        var isThere = false
        for city in models {
            if city.name == name {
                isThere = true
            }
        }
        if !isThere {
            let model = try! decoder.decode(City.self, from: jsonData)
            models.append(model)
        }
        
        return models
    }

    func getAll<T>(with type: T.Type) -> [T]? where T : NSManagedObject {
        
        let context = appDelegate.persistentContainer.viewContext
        
        let models = try? context.fetch((T.self).fetchRequest()) as! [T]
        
        return models
    }
}
