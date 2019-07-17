//
//  ViewController.swift
//  weatherApp
//
//  Created by Артур Гайсин on 17/07/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let weather = WeatherGetter()
    var cities:[City] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBOutlet weak var cityTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "didUnwindFromVC", let cityArr = sender as? [City] {
            
            if let destinationVC = segue.destination as? TableViewController {
                destinationVC.cities = cityArr
            }
        }
    }
    
    @IBAction func addCityButton(_ sender: Any) {
        weather.getWeather(city: cityTextField.text!, completionBlock: {[weak self] (response) in
            
            switch response {
            case let .Success(сities):
                self?.cities = сities
                self?.cancelButton(true)
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "didUnwindFromVC", sender: cities)
    }
}

