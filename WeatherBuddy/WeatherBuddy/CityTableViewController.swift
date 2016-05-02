//
//  CityTableViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

// https://www.andrewcbancroft.com/2015/03/17/basics-of-pull-to-refresh-for-swift-developers/#table-view-controller

import UIKit
import CoreLocation

// global variables to keep track of favorite cities and settings across tabs
var cities = FavoriteCities()
var settings = Settings()


class CityTableViewController: UITableViewController, CLLocationManagerDelegate {

    let defaults = NSUserDefaults.standardUserDefaults()
    let locManager = CLLocationManager()
    let ows = OpenWeatherService()
    var tempCity = [City]()
    var canRefresh = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        tableView.separatorStyle = .None
        
        self.tableView.backgroundColor = UIColor.init(red: 214/255, green: 238/255, blue: 255/255, alpha: 1.0)
        self.tableView.userInteractionEnabled = false
        
        // persistance for settings
        if let theme = defaults.valueForKey("savedTheme") as? String {
            if (theme == "Classic") {
                settings.theme = .Classic
            } else if (theme == "Dogs") {
                settings.theme = .Dogs
            } else {
                settings.theme = .NotreDame
            }
        }
        if let unit = defaults.valueForKey("savedUnits") as? String {
            if (unit == "Fahrenheit") {
                settings.units = .Fahrenheit
            } else if (unit == "Celsius") {
                settings.units = .Celsius
            } else {
                settings.units = .Kelvin
            }
        }
        
        // persistance for cities
        if (defaults.objectForKey("savedCityNames") == nil) {
            cities.addCity("", state: "", zip: "") // placeholder for current location
            cities.addCity("New York City", state: "NY", zip: "10001")
            cities.addCity("Chicago", state: "IL", zip: "60290")
            cities.addCity("Los Angeles", state: "CA", zip: "90001")
        } else {
            let cityNames = defaults.objectForKey("savedCityNames") as! [String]
            let cityStates = defaults.objectForKey("savedCityStates") as! [String]
            let cityZips = defaults.objectForKey("savedCityZips") as! [String]
            
            var i = 0
            while (i < cityNames.count) {
                cities.addCity(cityNames[i], state: cityStates[i], zip: cityZips[i])
                i += 1
            }
        }
        
        
        // get the weather for each city
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        self.canRefresh = false
    
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.canRefresh = false
            var i:Int = 0
            self.tempCity.removeAll()
            while (i < cities.cityCount() ) {
                self.ows.cityWeatherByZipcode(cities.cityAtIndex(i)) {
                    (cities) in
                    self.tempCity.append(cities)
                    self.tableView.reloadData()
                    self.canRefresh = true
                }
                i += 1
            }
            self.tableView.userInteractionEnabled = true
        }
        
        cities.changeWeather(self.tempCity)
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
   
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        if (canRefresh) {
            canRefresh = false
            var i = 0
            self.tempCity.removeAll()
            while (i < cities.cityCount() ) {
                self.ows.cityWeatherByZipcode(cities.cityAtIndex(i)) {
                    (city) in
                    self.tempCity.append(city)
                    self.tableView.reloadData()
                }
                i += 1
            }

            cities.changeWeather(self.tempCity)
            canRefresh = true
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        } else {
            refreshControl.endRefreshing()
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.topItem!.title = "WeatherBuddy"
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.cityCount()
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("cityCell", forIndexPath: indexPath)

        if let cityCell = cell as? CityTableViewCell {
            cityCell.nameLabel.text = cities.cityAtIndex(indexPath.row).name
            cityCell.detailLabel.text = cities.cityAtIndex(indexPath.row).detail
            cityCell.iconImage.image = cities.cityAtIndex(indexPath.row).icon
            
            // set gradient color and direction
            if (cities.cityAtIndex(indexPath.row).description == "Clear" || cities.cityAtIndex(indexPath.row).description == "Haze" || cities.cityAtIndex(indexPath.row).description == "Mist") {
                cityCell.gradientView.clouds = 0
                cityCell.gradientView.setNeedsDisplay()
            } else {
                cityCell.gradientView.clouds = 1
                cityCell.gradientView.setNeedsDisplay()
            }
            cityCell.gradientView.leftToRight = (indexPath.row)%2
            
            // set temperature label
            if (settings.units == .Kelvin) {
                cityCell.degreesLabel.text = "\(Int(cities.cityAtIndex(indexPath.row).currentTemp_K))\u{00B0}"
            } else if (settings.units == .Celsius) {
                cityCell.degreesLabel.text = "\(Int(cities.cityAtIndex(indexPath.row).currentTemp_C))\u{00B0}"
            } else {
                cityCell.degreesLabel.text = "\(Int(cities.cityAtIndex(indexPath.row).currentTemp_F))\u{00B0}"
            }
            
            // if first cell, then set image for current location
            if (indexPath.row == 0) {
                cityCell.locationImage.image = UIImage(named: "Location")
            }
            
            
        }
        return cell
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation = locations.last
        cities.cityAtIndex(0).updateUserLocation(currentLocation!)
        // Update weather at new current location
        var tempCity = [City]()
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.ows.cityWeatherByZipcode(cities.cityAtIndex(0)) {
                (cities) in
                tempCity.append(cities)
            }
        }
        
        cities.changeWeather(tempCity)
        self.tableView.reloadData()
    }

    
    // for conditional editing of the table view
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.item != 0 {
            return true
        } else {
            return false
        }
    }
    
    
    // for editing the table view
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            cities.removeCityAtIndex(indexPath.item)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    // for rearranging the table view
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        cities.rearrangeCities(fromIndexPath.row, toIndex: toIndexPath.row)
    }

    
    // for conditional rearranging of the table view
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        if indexPath.item != 0 {
            return true
        } else {
            return false
        }
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            if let detailVC = segue.destinationViewController as? CityDetailViewController,
                indexPath = tableView.indexPathForSelectedRow {
                    detailVC.city = cities.cityAtIndex(indexPath.row)
            }
        }
        if segue.identifier == "addSegue" {
            if let addVC = segue.destinationViewController as? AddCityViewController {
                addVC.cities = cities
            }
        }
    }


}
