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
    var sunrise1970:Double
    var sunset1970:Double
    var id:String
    //var id:Int
    var sunrise_date:Int?
    var sunset_date:Int?
    
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

        self.sunrise1970 = 0.0 //NSDate().timeIntervalSince1970
        self.sunset1970 = 0.0 //NSDate().timeIntervalSince1970
        self.id = ""
//=======
        //self.id = 0
        self.sunrise_date = 0
        self.sunset_date = 0
//>>>>>>> e9667ea56a08bdf7fa0f5c27bd9bfd14cd3642eb
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
                
            }
            else {
                print("Problem with data from geocoder")
            }
            
        })
        
    }
    
    

    
}