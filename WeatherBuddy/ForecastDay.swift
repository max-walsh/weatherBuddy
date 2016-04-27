//
//  ForecastDay.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/27/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation
import UIKit
class ForecastDay {
    var minTemp:Double
    var maxTemp:Double
    var description:String
    var icon = UIImage(named: "Sun")!
    
    init(minTemp: Double, maxTemp: Double, desc: String, icon:UIImage) {
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.description = desc
        self.icon = icon
    }
}