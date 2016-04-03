//
//  City.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 3/30/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation


class City {
    var currentTemp:Double
    var humidity:Int
    var description:String
    var minTemp:Double
    var maxTemp:Double
    var windSpeed:Double
    var windDirection:Double
    var rain:String
    var sunrise:Int
    var sunset:Int
    var name:String
    var state:String
    var zipcode:String
    var country:String
    var barometricPressure:Int
    var coordinates:Coordinates
    var ows:OpenWeatherService
    
    init() {
        self.currentTemp = 0.0
        self.humidity = 0
        self.description = ""
        self.minTemp = 0.0
        self.maxTemp = 0.0
        self.windSpeed = 0.0
        self.windDirection = 0.0
        self.rain = ""
        self.sunrise = 0
        self.sunset = 0
        self.name = "Notre Dame"
        self.state = "IN"
        self.zipcode = "46556"
        self.country = "United States of America"
        self.barometricPressure = 0
        self.coordinates = Coordinates()
        self.ows = OpenWeatherService()
        
    }
    
}