//
//  ContactTableViewCell.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/13/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var vignetteView: VignetteView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
