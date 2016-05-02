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
    
    // current temps
    var currentTemp_F:Double
    var currentTemp_C:Double
    var currentTemp_K:Double
    
    // min and max temps
    var minTemp_F:Double
    var maxTemp_F:Double
    var minTemp_C:Double
    var maxTemp_C:Double
    var minTemp_K:Double
    var maxTemp_K:Double
    
    // details
    var description:String // overall description (ex: Clouds)
    var detail:String // more descriptive (ex: "overcast clouds")
    var humidity:Int // percentage of humidity
    var windSpeed:Double // wind speed in mph
    var windDirection:String // direction of wind (ex: NE)
    var barometricPressure:Double // pressure in psi
    var clouds:String // percentage of cloud coverage

    // sunrise and sunset info
    var sunrise:String
    var sunset:String
    var sunrise1970:Double
    var sunset1970:Double
    var sunrise_date:Int?
    var sunset_date:Int?
    var timeZone:NSTimeZone
    var timeZoneOffset:Double
    
    // city info
    var name:String
    var state:String
    var zipcode:String
    var country:String
    var coordinates:CLLocation
    var id:String // unique city id is given by OpenWeatherService
    
    // images
    var icon:UIImage
    var backgroundImage_c:UIImage
    var backgroundImage_nd:UIImage
    var backgroundImage_dog:UIImage
    
    
    init() {
        
        // current temps
        self.currentTemp_F = 0.0
        self.currentTemp_C = 0.0
        self.currentTemp_K = 0.0
        
        // min and max temps
        self.minTemp_F = 0.0
        self.maxTemp_F = 0.0
        self.minTemp_C = 0.0
        self.maxTemp_C = 0.0
        self.minTemp_K = 0.0
        self.maxTemp_K = 0.0

        // details
        self.description = ""
        self.detail = ""
        self.humidity = 0
        self.windSpeed = 0.0
        self.windDirection = ""
        self.barometricPressure = 0.0
        self.clouds = ""
        
        // sunrise and sunset info
        self.sunrise = ""
        self.sunset = ""
        self.sunrise1970 = 0.0 //NSDate().timeIntervalSince1970
        self.sunset1970 = 0.0 //NSDate().timeIntervalSince1970
        self.sunrise_date = 0
        self.sunset_date = 0
        self.timeZone = NSTimeZone()
        self.timeZoneOffset = 0.0
        
        // city info
        self.name = ""
        self.state = ""
        self.zipcode = ""
        self.country = "United States of America"
        let lat:CLLocationDegrees = 41.7056
        let long:CLLocationDegrees = 86.2353
        self.coordinates = CLLocation(latitude: lat, longitude: long)
        self.id = ""
        
        // images
        self.icon = UIImage(named: "Sun")!
        self.backgroundImage_c = UIImage(named: "Clear_big")!
        self.backgroundImage_nd = UIImage(named: "nd_Clear")!
        self.backgroundImage_dog = UIImage(named: "Clear_dog")!

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
                /*
                self.timeZone = pm.timeZone!
                print(self.timeZone.secondsFromGMT)
                self.sunrise1970 += (Double(self.timeZone.secondsFromGMT) + 14400) // openWeather actually gives sunrise in only east coast time
                self.sunrise_date = Int(self.sunrise1970)
                self.sunset1970 += (Double(self.timeZone.secondsFromGMT) + 14400)
                self.sunset_date = Int(self.sunset1970)
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let srise = NSDate(timeIntervalSince1970: self.sunrise1970)
                self.sunrise = dateFormatter.stringFromDate(srise)
                self.sunrise = self.sunrise.stringByAppendingString(" AM")
                let sset = NSDate(timeIntervalSince1970: self.sunset1970)
                self.sunset = dateFormatter.stringFromDate(sset)
                self.sunset = self.sunset.stringByAppendingString(" PM")
                */
                
            }
            else {
                print("Problem with data from geocoder")
            }
            
        })
        
    }
    
    func updateSun(location: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Reverse Geocoder failed with error: \(error!.localizedDescription)")
                return
            }
            if let pm = placemarks![0] as? CLPlacemark {
            
                self.timeZone = pm.timeZone!
                //print(self.timeZone.secondsFromGMT)
                self.timeZoneOffset = Double(self.timeZone.secondsFromGMT) + 14400
                self.sunrise1970 += (Double(self.timeZone.secondsFromGMT) + 14400) // openWeather actually gives sunrise in only east coast time
                self.sunrise_date = Int(self.sunrise1970)
                self.sunset1970 += (Double(self.timeZone.secondsFromGMT) + 14400)
                self.sunset_date = Int(self.sunset1970)
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "hh:mm"
                let srise = NSDate(timeIntervalSince1970: self.sunrise1970)
                self.sunrise = dateFormatter.stringFromDate(srise)
                self.sunrise = self.sunrise.stringByAppendingString(" AM")
                let sset = NSDate(timeIntervalSince1970: self.sunset1970)
                self.sunset = dateFormatter.stringFromDate(sset)
                self.sunset = self.sunset.stringByAppendingString(" PM")

            }
            else {
                print("Problem with data from geocoder")
            }
        })
    }
    
    
}