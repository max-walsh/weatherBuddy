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
        if (settings.theme == .NotreDame) {
            backgroundImage.image = city?.backgroundImage_nd
        }
        else {
            backgroundImage.image = city?.backgroundImage_c
        }
        
        //day1Image.image = forecast?.dayAtIndex(0).icon
        day2Image.image = UIImage(named: "Cloud")
        //day2Image.image = forecast!.dayAtIndex(1).icon
        //day3Image.image = forecast!.dayAtIndex(2).icon
        //day4Image.image = forecast!.dayAtIndex(3).icon
        //day5Image.image = forecast!.dayAtIndex(4).icon

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
