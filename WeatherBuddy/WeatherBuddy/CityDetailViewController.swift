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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var barometricLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "\(city!.name), \(city!.state)"
        iconImage.image = city?.icon
        detailLabel.text = city?.detail
        zipLabel.text = city?.zipcode
        maxLabel.text = "Max: \(city!.maxTemp)"
        minLabel.text = "Min: \(city!.minTemp)"
        humidityLabel.text = "Humidity: \(city!.humidity)"
        windLabel.text = "Wind: \(city!.windSpeed) \(city!.windDirection)"
        sunriseLabel.text = "Sunrise: \(city!.sunrise)"
        sunsetLabel.text = "Sunset: \(city!.sunset)"
        barometricLabel.text = "Pressure: \(city!.barometricPressure)"

        // Do any additional setup after loading the view.
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
