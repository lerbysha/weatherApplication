//
//  TableViewController.swift
//  weatherApp
//
//  Created by Артур Гайсин on 17/07/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import UIKit
import CoreData
class TableViewController: UITableViewController {
    

    var cities: [City] = []
    let weather = WeatherGetter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 300
        
        cities = weather.getAll(with: City.self) ?? []
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        self.refreshControl = refreshControl
        self.tableView.addSubview(refreshControl)
        self.tableView.reloadData()
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        cities = weather.getAll(with: City.self) ?? []

        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }



    
    @IBAction func addButton(_ sender: Any) {
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.configureCell(with: cities[indexPath.row].name!, speed: String(cities[indexPath.row].speed), deg: String(cities[indexPath.row].deg), temp: String(cities[indexPath.row].temp))
        
        return cell
    }
 
    @IBAction func didUnwindFromVC(_ sender:UIStoryboardSegue){
    }
}
