//
//  ForecastDay.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/27/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation

class ForecastDay {
    var minTemp:Double
    var maxTemp:Double
    var description:String
    
    init(minTemp: Double, maxTemp: Double, desc: String) {
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.description = desc
    }
}