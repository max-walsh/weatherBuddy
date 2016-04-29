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
    var units:Unit
    
    init() {
        theme = Theme.Classic
        units = Unit.Fahrenheit
    }
}

enum Theme {
    case Classic
    case Dogs
    case NotreDame
}

enum Unit {
    case Fahrenheit
    case Celsius
    case Kelvin
}