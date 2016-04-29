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
    var minTemp_F:Double
    var maxTemp_F:Double
    var minTemp_C:Double
    var maxTemp_C:Double
    var minTemp_K:Double
    var maxTemp_K:Double
    var description:String
    var icon = UIImage(named: "Sun")!
    
    init(minTemp_F: Double, maxTemp_F: Double, desc: String, icon:UIImage) {
        self.minTemp_F = minTemp_F
        self.maxTemp_F = maxTemp_F
        self.minTemp_C = 0
        self.maxTemp_C = 0
        self.minTemp_K = 0
        self.maxTemp_K =  0
        self.description = desc
        self.icon = icon
    }
}