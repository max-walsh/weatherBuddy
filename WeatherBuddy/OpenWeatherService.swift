//
//  OpenWeatherService.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

class OpenWeatherService {
    
    var baseURL:String = "http://api.openweathermap.org/data/2.5/weather?"
    var apiKey:String = "93d98c361bc0d24cb301adc549eea5c4"
    var finalCity = City()
    
    /*
    init() {
        url = ""
        apiKey = ""
    }
    */
    /*
    func citiesWeatherByCoordinates(callback: (City)->Void) {
        //let i:Int = 0
        
        //let coordURL = "\(baseURL)lat=\(cities[i].coordinates.coordinate.latitude)&lon=\(cities[i].coordinates.coordinate.longitude)&APPID=\(apiKey)"
        
        let lat:CLLocationDegrees = 41.7056
        let long:CLLocationDegrees = 86.2353
        let coordURL = "\(baseURL)lat=\(lat)&lon=\(long)&APPID=\(apiKey)"
        
        let searchURL = NSURL(string: coordURL)
        let request = NSMutableURLRequest(URL: searchURL!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, responseText, error) -> Void in
            if error != nil {
                print(error)
            } else {
                let result = String(data: data!, encoding: NSASCIIStringEncoding)!
                
                // http://stackoverflow.com/questions/24056205/how-to-use-background-thread-in-swift
                let qualityOfServiceClass = QOS_CLASS_BACKGROUND
                let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
                
                //dispatch_async(dispatch_get_main_queue(), {
                dispatch_async(backgroundQueue, {
                    self.resultJSON = result
                    self.parseJSONCoordResponse(data!)
                    callback(self.cities)
                })
            }
        }
        task.resume()
    }*/
    
    func cityWeatherByZipcode(cities: City, callback: (City)->Void) {
        //print("call back zipcode: \(cities.zipcode)")
        //let zip = "46556"
        //let test = self.cities.zipcode
        //let coordURL = "\(baseURL)zip=\(zip),us&APPID=\(apiKey)"
        let coordURL = "\(baseURL)zip=\(cities.zipcode),us&APPID=\(apiKey)"
        
        let searchURL = NSURL(string: coordURL)
        let request = NSMutableURLRequest(URL: searchURL!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
        (data, responseText, error) -> Void in
            if error != nil {
                print(error)
            } else {
                let result = String(data: data!, encoding: NSASCIIStringEncoding)!
        
                // http://stackoverflow.com/questions/24056205/how-to-use-background-thread-in-swift
                let qualityOfServiceClass = QOS_CLASS_BACKGROUND
                let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
                //dispatch_async(dispatch_get_main_queue(), {
                dispatch_async(backgroundQueue, {
                    self.resultJSON = result
                    self.finalCity = self.parseJSONZipcodeResponse(data!, city: cities)
                    //callback(cities)
                    callback(self.finalCity)
                })
            }
        }
        task.resume()
    }
    
    
    
    
    var resultJSON : String = "" {
        didSet {
            print("setting output as \(resultJSON)")
            print("\n")
        }
    }
    
    func parseJSONZipcodeResponse(data: NSData, city: City) -> City {
        let json = JSON(data: data)
        //let maxTemp = json["main"]["temp_max"]
        city.currentTemp = json["main"]["temp"].doubleValue
        city.maxTemp = json["main"]["temp_max"].doubleValue
        city.minTemp = json["main"]["temp_min"].doubleValue
        city.humidity = json["main"]["humidity"].intValue
        city.description = json["weather"]["description"].stringValue // or json[weather][main] for more general
        city.windSpeed = json["wind"]["speed"].doubleValue
        city.windDirection = json["wind"]["direction"].doubleValue
        city.rain = json["clouds"]["all"].stringValue
        city.sunrise = json["sys"]["sunrise"].intValue
        city.sunset = json["sys"]["sunset"].intValue
        city.barometricPressure = json["main"]["pressure"].doubleValue
        let long = json["coord"]["long"].doubleValue
        let lat = json["coord"]["lat"].doubleValue
        city.coordinates = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        
        //print(name)
        return city
        
    }
}