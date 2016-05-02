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
    
    // min and max temps for the day
    var minTemp_F: Double
    var maxTemp_F: Double
    var minTemp_C: Double
    var maxTemp_C: Double
    var minTemp_K: Double
    var maxTemp_K: Double
    
    // description (ex: Rain)
    var description: String
    // icon corresponding to the description
    var icon = UIImage(named: "Sun")!
    
    init(minTemp_F: Double, maxTemp_F: Double,
         minTemp_C: Double, maxTemp_C: Double,
         minTemp_K: Double, maxTemp_K: Double, desc: String, icon:UIImage) {
        
        self.minTemp_F = minTemp_F
        self.maxTemp_F = maxTemp_F
        self.minTemp_C = minTemp_C
        self.maxTemp_C = maxTemp_C
        self.minTemp_K = minTemp_K
        self.maxTemp_K = maxTemp_K
        
        self.description = desc
        self.icon = icon
    }
}