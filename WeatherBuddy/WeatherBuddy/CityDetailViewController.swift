//
//  CityDetailViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/5/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {

    var city: City?
    var forecast: Forecast?
    let ows = OpenWeatherService()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sunView: SunView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var barometricLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    // 5 Day Forecast Labels
    @IBOutlet weak var day1Label: UILabel!
    @IBOutlet weak var day2Label: UILabel!
    @IBOutlet weak var day3Label: UILabel!
    @IBOutlet weak var day4Label: UILabel!
    @IBOutlet weak var day5Label: UILabel!
    // Forecast Icons
    @IBOutlet weak var day1Image: UIImageView!
    @IBOutlet weak var day2Image: UIImageView!
    @IBOutlet weak var day3Image: UIImageView!
    @IBOutlet weak var day4Image: UIImageView!
    @IBOutlet weak var day5Image: UIImageView!
    // Forecast Max Temps
    @IBOutlet weak var day1MaxLabel: UILabel!
    @IBOutlet weak var day2MaxLabel: UILabel!
    @IBOutlet weak var day3MaxLabel: UILabel!
    @IBOutlet weak var day4MaxLabel: UILabel!
    @IBOutlet weak var day5MaxLabel: UILabel!
    // Forecast Min Temps
    @IBOutlet weak var day1MinLabel: UILabel!
    @IBOutlet weak var day2MinLabel: UILabel!
    @IBOutlet weak var day3MinLabel: UILabel!
    @IBOutlet weak var day4MinLabel: UILabel!
    @IBOutlet weak var day5MinLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.title = "Back"
        
        // Set Labels
        nameLabel.text = "\(city!.name), \(city!.state)"
        detailLabel.text = city?.detail
        humidityLabel.text = "Humidity: \(city!.humidity)%"
        windLabel.text = "Wind: \(city!.windSpeed) mph \(city!.windDirection)"
        barometricLabel.text = "Pressure: \(city!.barometricPressure) psi"
        cloudLabel.text = "Clouds: \(city!.clouds)%"
        sunriseLabel.text = "\(city!.sunrise)"
        sunsetLabel.text = "\(city!.sunset)"
        setDayLabels()
        
        // Set temperature labels
        if (settings.units == .Kelvin) {
            tempLabel.text = "\(Int(city!.currentTemp_K))\u{00B0}"
            maxLabel.text = "High: \(Int(city!.maxTemp_K))\u{00B0}"
            minLabel.text = "Low: \(Int(city!.minTemp_K))\u{00B0}"
        } else if (settings.units == .Celsius) {
            tempLabel.text = "\(Int(city!.currentTemp_C))\u{00B0}"
            maxLabel.text = "High: \(Int(city!.maxTemp_C))\u{00B0}"
            minLabel.text = "Low: \(Int(city!.minTemp_C))\u{00B0}"
        } else {
            tempLabel.text = "\(Int(city!.currentTemp_F))\u{00B0}"
            maxLabel.text = "High: \(Int(city!.maxTemp_F))\u{00B0}"
            minLabel.text = "Low: \(Int(city!.minTemp_F))\u{00B0}"
        }
        
        
        // set data in sunView
        sunView.riseTime = city!.sunrise_date
        sunView.setTime = city!.sunset_date
        sunView.timeZone = city!.timeZone

        
        // get forecast information and set labels
        self.ows.cityWeatherForecast(city!) {
            (forecast) in
            self.forecast = forecast
            self.day1Image.image = self.forecast!.dayAtIndex(0).icon
            self.day2Image.image = self.forecast!.dayAtIndex(1).icon
            self.day3Image.image = self.forecast!.dayAtIndex(2).icon
            self.day4Image.image = self.forecast!.dayAtIndex(3).icon
            self.day5Image.image = self.forecast!.dayAtIndex(4).icon
            if (settings.units == .Kelvin) {
                self.setLabels_K()
            } else if (settings.units == .Celsius) {
                self.setLabels_C()
            } else {
                self.setLabels_F()
            }
        }
        
        // Set background image
        if (settings.theme == .Classic) {
            backgroundImage.image = city?.backgroundImage_c
        } else if (settings.theme == .NotreDame) {
            backgroundImage.image = city?.backgroundImage_nd
        } else if (settings.theme == .Dogs) {
            backgroundImage.image = city?.backgroundImage_dog
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // set temperature labels
        if (settings.units == .Kelvin) {
            tempLabel.text = "\(Int(city!.currentTemp_K))\u{00B0}"
            maxLabel.text = "High: \(Int(city!.maxTemp_K))\u{00B0}"
            minLabel.text = "Low: \(Int(city!.minTemp_K))\u{00B0}"
        } else if (settings.units == .Celsius) {
            tempLabel.text = "\(Int(city!.currentTemp_C))\u{00B0}"
            maxLabel.text = "High: \(Int(city!.maxTemp_C))\u{00B0}"
            minLabel.text = "Low: \(Int(city!.minTemp_C))\u{00B0}"
        } else {
            tempLabel.text = "\(Int(city!.currentTemp_F))\u{00B0}"
            maxLabel.text = "High: \(Int(city!.maxTemp_F))\u{00B0}"
            minLabel.text = "Low: \(Int(city!.minTemp_F))\u{00B0}"
        }
        
        // Set data in sunView
        sunView.riseTime = city!.sunrise_date
        sunView.setTime = city!.sunset_date
        sunView.timeZone = city!.timeZone
        
        
        // Get forecast information and set labels
        self.ows.cityWeatherForecast(city!) {
            (forecast) in
            self.forecast = forecast
            //print(self.forecast)
            self.day1Image.image = self.forecast!.dayAtIndex(0).icon
            self.day2Image.image = self.forecast!.dayAtIndex(1).icon
            self.day3Image.image = self.forecast!.dayAtIndex(2).icon
            self.day4Image.image = self.forecast!.dayAtIndex(3).icon
            self.day5Image.image = self.forecast!.dayAtIndex(4).icon
            if (settings.units == .Kelvin) {
                self.setLabels_K()
            } else if (settings.units == .Celsius) {
                self.setLabels_C()
            } else {
                self.setLabels_F()
            }
        }
        
        // set background image
        if (settings.theme == .Classic) {
            backgroundImage.image = city?.backgroundImage_c
        } else if (settings.theme == .NotreDame) {
            backgroundImage.image = city?.backgroundImage_nd
        } else if (settings.theme == .Dogs) {
            backgroundImage.image = city?.backgroundImage_dog
        }
    }
    
    
    
    // Functions for setting forecast labels
    func setLabels_K() {
        self.day1MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(0).maxTemp_K)))\u{00B0}"
        self.day2MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(1).maxTemp_K)))\u{00B0}"
        self.day3MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(2).maxTemp_K)))\u{00B0}"
        self.day4MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(3).maxTemp_K)))\u{00B0}"
        self.day5MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(4).maxTemp_K)))\u{00B0}"
        self.day1MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(0).minTemp_K)))\u{00B0}"
        self.day2MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(1).minTemp_K)))\u{00B0}"
        self.day3MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(2).minTemp_K)))\u{00B0}"
        self.day4MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(3).minTemp_K)))\u{00B0}"
        self.day5MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(4).minTemp_K)))\u{00B0}"
    }
    
    func setLabels_C() {
        self.day1MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(0).maxTemp_C)))\u{00B0}"
        self.day2MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(1).maxTemp_C)))\u{00B0}"
        self.day3MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(2).maxTemp_C)))\u{00B0}"
        self.day4MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(3).maxTemp_C)))\u{00B0}"
        self.day5MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(4).maxTemp_C)))\u{00B0}"
        self.day1MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(0).minTemp_C)))\u{00B0}"
        self.day2MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(1).minTemp_C)))\u{00B0}"
        self.day3MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(2).minTemp_C)))\u{00B0}"
        self.day4MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(3).minTemp_C)))\u{00B0}"
        self.day5MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(4).minTemp_C)))\u{00B0}"
    }
    
    func setLabels_F() {
        self.day1MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(0).maxTemp_F)))\u{00B0}"
        self.day2MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(1).maxTemp_F)))\u{00B0}"
        self.day3MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(2).maxTemp_F)))\u{00B0}"
        self.day4MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(3).maxTemp_F)))\u{00B0}"
        self.day5MaxLabel.text = "\(Int(round(self.forecast!.dayAtIndex(4).maxTemp_F)))\u{00B0}"
        self.day1MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(0).minTemp_F)))\u{00B0}"
        self.day2MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(1).minTemp_F)))\u{00B0}"
        self.day3MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(2).minTemp_F)))\u{00B0}"
        self.day4MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(3).minTemp_F)))\u{00B0}"
        self.day5MinLabel.text = "\(Int(round(self.forecast!.dayAtIndex(4).minTemp_F)))\u{00B0}"
    }
    
    func setDayLabels() {
        let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        let day = 86400 // seconds in a day
        
        let currentDay = Int(NSDate().timeIntervalSince1970 + city!.timeZoneOffset)
 
        let day1 = NSDate(timeIntervalSince1970: NSTimeInterval(currentDay))
        let day2 = NSDate(timeIntervalSince1970: NSTimeInterval(currentDay + day))
        let day3 = NSDate(timeIntervalSince1970: NSTimeInterval(currentDay + (2*day)))
        let day4 = NSDate(timeIntervalSince1970: NSTimeInterval(currentDay + (3*day)))
        let day5 = NSDate(timeIntervalSince1970: NSTimeInterval(currentDay + (4*day)))
     
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let myComponents_1 = myCalendar.components(.Weekday, fromDate: day1)
        let myComponents_2 = myCalendar.components(.Weekday, fromDate: day2)
        let myComponents_3 = myCalendar.components(.Weekday, fromDate: day3)
        let myComponents_4 = myCalendar.components(.Weekday, fromDate: day4)
        let myComponents_5 = myCalendar.components(.Weekday, fromDate: day5)
        
        self.day1Label.text = days[myComponents_1.weekday - 1]
        self.day2Label.text = days[myComponents_2.weekday - 1]
        self.day3Label.text = days[myComponents_3.weekday - 1]
        self.day4Label.text = days[myComponents_4.weekday - 1]
        self.day5Label.text = days[myComponents_5.weekday - 1]
        
    }
}
