//
//  Forecast.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/27/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation

class Forecast {
    
    private var days:[ForecastDay] = []
    
    func addDay(day: ForecastDay) -> Void {
        days.append(day)
    }
    
    func dayAtIndex(index: Int) -> ForecastDay {
        return days[index]
    }
    
}