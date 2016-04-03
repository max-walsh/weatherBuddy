//
//  Settings.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation

class Settings {
    var theme:Theme
    var accessContacts:Bool
    var notifications:Bool
    var units:Bool
    
    init() {
        theme = Theme.Classic
        accessContacts = false
        notifications = false
        units = true
    }
}