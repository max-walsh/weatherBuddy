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
    @IBOutlet weak var day1Image: UIImageView!
    @IBOutlet weak var day2Image: UIImageView!
    @IBOutlet weak var day3Image: UIImageView!
    @IBOutlet weak var day4Image: UIImageView!
    @IBOutlet weak var day5Image: UIImageView!
    
    
    
    let ows = OpenWeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "\(city!.name), \(city!.state)"
        detailLabel.text = city?.detail
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
        humidityLabel.text = "Humidity: \(city!.humidity)%"
        windLabel.text = "Wind: \(city!.windSpeed) mph \(city!.windDirection)"
        sunriseLabel.text = "\(city!.sunrise)"
        sunView.rise = city!.sunrise_date
        sunView.set = city!.sunset_date
        sunsetLabel.text = "\(city!.sunset)"
        barometricLabel.text = "Pressure: \(city!.barometricPressure) psi"
        cloudLabel.text = "Clouds: \(city!.clouds)%"

        // Do any additional setup after loading the view.
        /*
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_async(priority, 0)) {
        
        }
        */
        self.ows.cityWeatherForecast(city!) {
            (forecast) in
            self.forecast = forecast
            print(self.forecast)
            self.day1Image.image = self.forecast!.dayAtIndex(0).icon
            self.day2Image.image = self.forecast!.dayAtIndex(1).icon
            self.day3Image.image = self.forecast!.dayAtIndex(2).icon
            self.day4Image.image = self.forecast!.dayAtIndex(3).icon
            self.day5Image.image = self.forecast!.dayAtIndex(4).icon
            //print("should have been called")
            //self. MUST REFRESH THE DATA
        }
        
        

        sunriseImage.image = UIImage(named: "Sunrise")
        sunsetImage.image = UIImage(named: "Sunset")
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
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
