//
//  TableViewCell.swift
//  weatherApp
//
//  Created by Артур Гайсин on 17/07/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var degLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(with name: String,speed: String, deg:String, temp: String ){
        nameLabel.text = "City Name : \(name)"
        tempLabel.text = "Current Temperature : \(temp)"
        degLabel.text = "Current Wind Degree: \(deg)"
        speedLabel.text = "Current Wind Speed: \(speed)"
        
    }
}
