//
//  Contact.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation

class Contact {
    var name:String
    var city:City
    
    init(name: String, city: City) {
        self.name = name
        self.city = city
    }
}