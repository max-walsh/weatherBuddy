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
    var cityWeather = City()
    // http://api.openweathermap.org/data/2.5/forecast?q=London,us&APPID=93d98c361bc0d24cb301adc549eea5c4
    
    /*
    init() {
        url = ""
        apiKey = ""
    }
    */
    
    func cityWeatherByZipcode(cities: City, callback: (City)->Void) {
        //print("call back zipcode: \(cities.zipcode)")
        //let zip = "46556"
        //let test = self.cities.zipcode
        //let coordURL = "\(baseURL)zip=\(zip),us&APPID=\(apiKey)"
        let coordURL = "\(baseURL)zip=\(cities.zipcode),us&APPID=\(apiKey)"
        let searchURL = NSURL(string: coordURL)
        //print("url: \(searchURL)")
        let request = NSMutableURLRequest(URL: searchURL!)
        sleep(1)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
        (data, responseText, error) -> Void in
            if error != nil {
                print(error)
            } else {
                let result = String(data: data!, encoding: NSASCIIStringEncoding)!
                //print("data: \(data!)")
                if (data == nil) {
                    
                }
                // http://stackoverflow.com/questions/24056205/how-to-use-background-thread-in-swift
                //`let qualityOfServiceClass = QOS_CLASS_BACKGROUND
                //let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
                self.resultJSON = result
                self.cityWeather = self.parseJSONZipcodeResponse(data!, city: cities)
                
                dispatch_async(dispatch_get_main_queue(), {
                //dispatch_async(backgroundQueue, {
                    
                    //callback(cities)
                    callback(self.cityWeather)
                    /*
                    dispatch_async(dispatch_get_main_queue(), { ()->Void in
                        print("What")
                        
                    })
                    */
                })
            }
        }
        task.resume()
    }
    
    
    
    
    var resultJSON : String = "" {
        didSet {
            //print("setting output as \(resultJSON)")
            //print("\n")
        }
    }
    
    func parseJSONZipcodeResponse(data: NSData, city: City) -> City {
        let json = JSON(data: data)
        //let maxTemp = json["main"]["temp_max"]
        city.currentTemp = KtoF(json["main"]["temp"].doubleValue)
        //print("name: \(city.name)   temp: \(city.currentTemp)")
        city.maxTemp = KtoF(json["main"]["temp_max"].doubleValue)
        city.minTemp = KtoF(json["main"]["temp_min"].doubleValue)
        city.humidity = json["main"]["humidity"].intValue
        city.description = json["weather"][0]["main"].stringValue // more general
        city.detail = json["weather"][0]["description"].stringValue // more specific
        //print("in json, description = \(city.description)")
        city.windSpeed = json["wind"]["speed"].doubleValue
        city.windDirection = json["wind"]["direction"].doubleValue
        city.rain = json["clouds"]["all"].stringValue
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let srise = NSDate(timeIntervalSince1970: json["sys"]["sunrise"].doubleValue)
        city.sunrise = dateFormatter.stringFromDate(srise)
        city.sunrise = city.sunrise.stringByAppendingString(" AM")
        let sset = NSDate(timeIntervalSince1970: json["sys"]["sunset"].doubleValue)
        city.sunset = dateFormatter.stringFromDate(sset)
        city.sunset = city.sunset.stringByAppendingString(" PM")
        city.barometricPressure = json["main"]["pressure"].doubleValue
        let long = json["coord"]["lon"].doubleValue
        let lat = json["coord"]["lat"].doubleValue
        city.coordinates = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        
        // settting icon image
        if (city.description == "Clear") {
            city.icon = UIImage(named: "Sun")!
        }
        else if (city.description == "Clouds") {
            city.icon = UIImage(named: "Cloud")!
        }
        else if (city.description == "Drizzle") {
            city.icon = UIImage(named: "Drizzle")!
        }
        else if (city.description == "Rain") {
            city.icon = UIImage(named: "Rain")!
        }
        else if (city.description == "Thunderstorm") {
            city.icon = UIImage(named: "Storm")!
        }
        else if (city.description == "Snow") {
            city.icon = UIImage(named: "Snow")!
        }
        else if (city.description == "Mist") {
            city.icon = UIImage(named: "FogDay")!
        }
        
        return city
        
    }
    
    func KtoF(K_Temp: Double) -> Double {
        return round(((K_Temp - 273.15)*1.8000) + 32.00)
    }
}