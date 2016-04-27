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
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var sunsetImage: UIImageView!
    @IBOutlet weak var sunriseImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    let ows = OpenWeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLabel.text = "\(city!.name), \(city!.state)"
        detailLabel.text = city?.detail
        tempLabel.text = "\(Int(city!.currentTemp))\u{00B0}"
        maxLabel.text = String(Int(city!.maxTemp))
        minLabel.text = String(Int(city!.minTemp))
        humidityLabel.text = "Humidity: \(city!.humidity)"
        windLabel.text = "Wind: \(city!.windSpeed) \(city!.windDirection)"
        sunriseLabel.text = "\(city!.sunrise)"
        sunView.rise = city!.sunrise_date
        sunView.set = city!.sunset_date
        sunsetLabel.text = "\(city!.sunset)"
        barometricLabel.text = "Pressure: \(city!.barometricPressure)"
        rainLabel.text = "Rain: \(city!.rain)"

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
            //print("should have been called")
            //self. MUST REFRESH THE DATA
        }
        
        

        sunriseImage.image = UIImage(named: "Sunrise")
        sunsetImage.image = UIImage(named: "Sunset")
        
        if (city?.description == "Clouds") {
            backgroundImage.image = UIImage(named: "Cloud_big")
        }
        else if (city?.description == "Clear") {
            backgroundImage.image = UIImage(named: "Clear_big")
        }
        else if (city?.description == "Rain") {
            backgroundImage.image = UIImage(named: "Rain_big")
        }
        else if (city?.description == "Mist" || city?.description == "Haze") {
            backgroundImage.image = UIImage(named: "Clear_big")
        }
        else if (city?.description == "Drizzle") {
            backgroundImage.image = UIImage(named: "Rain_big")
        }
        else if (city?.description == "Thunderstorm") {
            backgroundImage.image = UIImage(named: "Storm_big")
        }
        else if (city?.description == "Snow") {
            backgroundImage.image = UIImage(named: "Snow_big")
        }
        else {
            backgroundImage.image = UIImage(named: "Clear_big")
            print(city!.description)
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
