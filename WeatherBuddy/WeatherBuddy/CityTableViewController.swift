//
//  CityTableViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit
import CoreLocation


// TODO: Get it to stop looking for location updates when the location has changed and not changed

var cities = FavoriteCities()

class CityTableViewController: UITableViewController, CLLocationManagerDelegate {

    //var cities = FavoriteCities()
    var city1=[City]()
    //var cities = [City]()
    let locManager = CLLocationManager()
    let ows = OpenWeatherService()
    
    let tbc = TabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // https://www.andrewcbancroft.com/2015/03/17/basics-of-pull-to-refresh-for-swift-developers/#table-view-controller
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        //cities.addCity("", state: "", zip: "")
        cities.addCity("", state: "", zip: "")
        cities.addCity("New York City", state: "NY", zip: "10001")
        cities.addCity("Chicago", state: "IL", zip: "60290")
        cities.addCity("Los Angeles", state: "CA", zip: "90001")
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var i:Int = 0
            while (i < cities.cityCount() ) {
                self.ows.cityWeatherByZipcode(cities.cityAtIndex(i)) {
                    (cities) in
                    self.city1.append(cities)
                    print("name: \(cities.name)     temp: \(cities.currentTemp)")
                    self.tableView.reloadData()
                }
                i += 1
            }
        }
        
        cities.changeWeather(self.city1)
        
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        print("refreshed!")
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var i:Int = 0
            while (i < cities.cityCount() ) {
                self.ows.cityWeatherByZipcode(cities.cityAtIndex(i)) {
                    (cities) in
                    self.city1.append(cities)
                    print("name: \(cities.name)     temp: \(cities.currentTemp)")
                    self.tableView.reloadData()
                }
                i += 1
            }
        }
        
        cities.changeWeather(self.city1)
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.cityCount()
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("cityCell", forIndexPath: indexPath)
        
        if let cityCell = cell as? CityTableViewCell {
            cityCell.nameLabel.text = cities.cityAtIndex(indexPath.row).name
            cityCell.degreesLabel.text = String(Int(cities.cityAtIndex(indexPath.row).currentTemp))
            cityCell.detailLabel.text = cities.cityAtIndex(indexPath.row).detail
            cityCell.iconImage.image = cities.cityAtIndex(indexPath.row).icon
            
        }


        return cell
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //locationManager.startUpdatingLocation()
        let currentLocation = locations.last
        cities.cityAtIndex(0).updateUserLocation(currentLocation!)
        self.tableView.reloadData()
        print("current Location: \(currentLocation)")
        
        //locManager.stopUpdatingLocation() // stop looking at location
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
