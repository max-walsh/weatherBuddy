//
//  CityTableViewCell.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gradientView: GradientView! // blue or gray gradient depending on weather
    @IBOutlet weak var nameLabel: UILabel! // name of the city
    @IBOutlet weak var locationImage: UIImageView! // indicates current location
    @IBOutlet weak var degreesLabel: UILabel! // current temp
    @IBOutlet weak var iconImage: UIImageView! // icon corresponding to weather
    @IBOutlet weak var detailLabel: UILabel! // short description of current weather (ex: clear sky)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
