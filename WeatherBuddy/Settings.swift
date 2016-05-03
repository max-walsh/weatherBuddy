//
//  Settings.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation

class Settings {
    var theme: Theme
    var units: Unit
    
    init() {
        // default values
        theme = Theme.Classic
        units = Unit.Fahrenheit
    }
}

// need to use strings in enums for persistance
enum Theme: String {
    case Classic = "Classic"
    case Dogs = "Dogs"
    case NotreDame = "NotreDame"
}
enum Unit: String {
    case Fahrenheit = "Fahrenheit"
    case Celsius = "Celsius"
    case Kelvin = "Kelvin"
}