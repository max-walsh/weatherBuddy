//
//  Contact.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation
import UIKit

class Contact {
    
    var name: String
    var city: City
    var image: UIImage
    
    init(name: String, city: City) {
        
        self.name = name
        self.city = city
        
        // placeholder image, overridden if contact has image
        self.image = UIImage(named: "Contact")!
    
    }

}