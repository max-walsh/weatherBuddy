//
//  CityDetailViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/5/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {

    var city : City?
    var forecast : Forecast?
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
    @IBOutlet weak var sunsetImage: UIImageView!
    @IBOutlet weak var sunriseImage: UIImageView!
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
        
        // Set Labels
        nameLabel.text = "\(city!.name), \(city!.state)"
        detailLabel.text = city?.detail
        humidityLabel.text = "Humidity: \(city!.humidity)%"
        windLabel.text = "Wind: \(city!.windSpeed) mph \(city!.windDirection)"
        barometricLabel.text = "Pressure: \(city!.barometricPressure) psi"
        cloudLabel.text = "Clouds: \(city!.clouds)%"
        sunriseLabel.text = "\(city!.sunrise)"
        sunsetLabel.text = "\(city!.sunset)"
        
        // Set temperature labels
        if (settings.units == .Kelvin) {
            tempLabel.text = "\(Int(city!.currentTemp_K))\u{00B0}"
            maxLabel.text = String(Int(city!.maxTemp_K))
            minLabel.text = String(Int(city!.minTemp_K))
        }
        else if (settings.units == .Celsius) {
            tempLabel.text = "\(Int(city!.currentTemp_C))\u{00B0}"
            maxLabel.text = String(Int(city!.maxTemp_C))
            minLabel.text = String(Int(city!.minTemp_C))
        }
        else {
            tempLabel.text = "\(Int(city!.currentTemp_F))\u{00B0}"
            maxLabel.text = String(Int(city!.maxTemp_F))
            minLabel.text = String(Int(city!.minTemp_F))
        }
        
        
        // Set data in sunView
        sunView.riseTime = city!.sunrise_date
        sunView.setTime = city!.sunset_date
        
        // Do any additional setup after loading the view.
        /*
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_async(priority, 0)) {
        
        }
        */
        
        // Get forecast information and set labels
        self.ows.cityWeatherForecast(city!) {
            (forecast) in
            self.forecast = forecast
            print(self.forecast)
            self.day1Image.image = self.forecast!.dayAtIndex(0).icon
            self.day2Image.image = self.forecast!.dayAtIndex(1).icon
            self.day3Image.image = self.forecast!.dayAtIndex(2).icon
            self.day4Image.image = self.forecast!.dayAtIndex(3).icon
            self.day5Image.image = self.forecast!.dayAtIndex(4).icon
            if (settings.units == .Kelvin) {
                self.setLabels_K()
            }
            else if (settings.units == .Celsius) {
                self.setLabels_C()
            }
            else {
                self.setLabels_F()
            }
            //print("should have been called")
            //self. MUST REFRESH THE DATA
        }
        
        // Set background image
        if (settings.theme == .Classic) {
            backgroundImage.image = city?.backgroundImage_c
        }
        else if (settings.theme == .NotreDame) {
            backgroundImage.image = city?.backgroundImage_nd
        }
        else if (settings.theme == .Dogs) {
            backgroundImage.image = city?.backgroundImage_dog
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Functions for setting forecast temperature labels
    func setLabels_K() {
        self.day1MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(0).maxTemp_K)))
        self.day2MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(1).maxTemp_K)))
        self.day3MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(2).maxTemp_K)))
        self.day4MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(3).maxTemp_K)))
        self.day5MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(4).maxTemp_K)))
        self.day1MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(0).minTemp_K)))
        self.day2MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(1).minTemp_K)))
        self.day3MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(2).minTemp_K)))
        self.day4MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(3).minTemp_K)))
        self.day5MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(4).minTemp_K)))
    }
    
    func setLabels_C() {
        self.day1MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(0).maxTemp_C)))
        self.day2MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(1).maxTemp_C)))
        self.day3MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(2).maxTemp_C)))
        self.day4MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(3).maxTemp_C)))
        self.day5MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(4).maxTemp_C)))
        self.day1MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(0).minTemp_C)))
        self.day2MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(1).minTemp_C)))
        self.day3MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(2).minTemp_C)))
        self.day4MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(3).minTemp_C)))
        self.day5MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(4).minTemp_C)))
    }
    
    func setLabels_F() {
        self.day1MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(0).maxTemp_F)))
        self.day2MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(1).maxTemp_F)))
        self.day3MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(2).maxTemp_F)))
        self.day4MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(3).maxTemp_F)))
        self.day5MaxLabel.text = String(Int(round(self.forecast!.dayAtIndex(4).maxTemp_F)))
        self.day1MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(0).minTemp_F)))
        self.day2MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(1).minTemp_F)))
        self.day3MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(2).minTemp_F)))
        self.day4MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(3).minTemp_F)))
        self.day5MinLabel.text = String(Int(round(self.forecast!.dayAtIndex(4).minTemp_F)))
    }
}
