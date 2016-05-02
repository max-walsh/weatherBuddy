//
//  ContactTableViewCell.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/13/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var vignetteView: VignetteView! // gradient over the background image
    @IBOutlet weak var backgroundImage: UIImageView! // image corresponds to weather
    
    @IBOutlet weak var nameLabel: UILabel! // name of contact
    @IBOutlet weak var addressLabel: UILabel! // contact's city
    @IBOutlet weak var contactImage: UIImageView! // image of contact
    @IBOutlet weak var detailLabel: UILabel! // description of current weather
    @IBOutlet weak var degreeLabel: UILabel! // current temp
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
