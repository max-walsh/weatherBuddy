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
    var detail:String
    var minTemp:Double
    var maxTemp:Double
    var windSpeed:Double
    var windDirection:Double
    var rain:String
    var sunrise:String
    var sunset:String
    var name:String
    var state:String
    var zipcode:String
    var country:String
    var barometricPressure:Double
    var coordinates:CLLocation
    var icon:UIImage
    var timeZone:NSTimeZone
    
    init() {
        self.currentTemp = 0.0
        self.humidity = 0
        self.description = ""
        self.detail = ""
        self.minTemp = 0.0
        self.maxTemp = 0.0
        self.windSpeed = 0.0
        self.windDirection = 0.0
        self.rain = ""
        self.sunrise = ""
        self.sunset = ""
        self.name = ""
        self.state = ""
        self.zipcode = ""
        self.country = "United States of America"
        self.barometricPressure = 0
        let lat:CLLocationDegrees = 41.7056
        let long:CLLocationDegrees = 86.2353
        self.coordinates = CLLocation(latitude: lat, longitude: long)
        self.icon = UIImage(named: "Sun")!
        self.timeZone = NSTimeZone()
    }
    
    
    func updateUserLocation(location: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Reverse Geocoder failed with error: \(error!.localizedDescription)")
                return
            }
            if let pm = placemarks![0] as? CLPlacemark {
                self.name = pm.locality!
                self.state = pm.administrativeArea!
                self.zipcode = pm.postalCode!
                self.country = pm.country!
                self.coordinates = pm.location!
                self.timeZone = pm.timeZone!
            }
            else {
                print("Problem with data from geocoder")
            }
            
        })
        
    }
    
    

    
}