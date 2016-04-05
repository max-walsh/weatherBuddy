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

class CityTableViewController: UITableViewController, CLLocationManagerDelegate {

    var cities = [City]()
    var city1 = City()
    let locManager = CLLocationManager()
    let ows = OpenWeatherService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        /*
        ows.citiesWeatherByCoordinates {
            (cities) in
            self.cities = cities
            self.tableView.reloadData()
        }
        */
        cities.append(City())
        cities.append(City())
        cities.append(City())

        print("loaded")
        

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
        return cities.count
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("cityCell", forIndexPath: indexPath)
        
        if let cityCell = cell as? CityTableViewCell {
            cityCell.nameLabel.text = cities[indexPath.row].name
        }


        return cell
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //locationManager.startUpdatingLocation()
        let currentLocation = locations.last
        cities[0].updateUserLocation(currentLocation!)
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
                    detailVC.city = cities[indexPath.row]
            }
        }
    }


}
