//
//  Contact.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation

class Contact {
    var firstName:String
    var lastName:String
    var city:City
    
    init() {
        firstName = ""
        lastName = ""
        city = City()
    }
}