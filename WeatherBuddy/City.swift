//
//  City.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 3/30/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON


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
    var gms:GoogleMapsService
    
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
        self.gms = GoogleMapsService()
        
    }
    
    
    func updateUserLocation(location: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Reverse Geocoder failed with error: \(error!.localizedDescription)")
                return
            }
            if let pm = placemarks![0] as? CLPlacemark {
                print("locality: \(pm.locality)")
                self.name = pm.locality!
                self.state = pm.administrativeArea!
                self.zipcode = pm.postalCode!
                self.country = pm.country!
            }
            else {
                print("Problem with data from geocoder")
            }
            
        })
        
    }
    
    

    
}