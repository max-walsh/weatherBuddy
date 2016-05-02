//
//  ContactTableViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/13/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

// http://code.tutsplus.com/tutorials/ios-9-an-introduction-to-the-contacts-framework--cms-25599
// http://stackoverflow.com/questions/32669612/how-to-fetch-all-contacts-record-in-ios-9-using-contacts-framework


import UIKit
import Contacts
import ContactsUI


class ContactTableViewController: UITableViewController {
    
    let ows = OpenWeatherService()
    var contacts = [CNContact]() // holds all the phone's contacts
    var contacts_addr = [Contact]() // holds contacts with address
    var city1 = [City]()
    
    func getContacts() {
        let store = CNContactStore()
        
        if CNContactStore.authorizationStatusForEntityType(.Contacts) == .NotDetermined {
            store.requestAccessForEntityType(.Contacts, completionHandler: { (authorized: Bool, error: NSError?) -> Void in
                if authorized {
                    self.retrieveContactsWithStore(store)
                }
            })
        } else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Authorized {
            self.retrieveContactsWithStore(store)
        }
    }
    
    func retrieveContactsWithStore(store: CNContactStore) {
        do {
            
            let containerId = CNContactStore().defaultContainerIdentifier()
            let predicate: NSPredicate = CNContact.predicateForContactsInContainerWithIdentifier(containerId)
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactEmailAddressesKey, CNContactPostalAddressesKey, CNContactImageDataKey, CNContactImageDataAvailableKey, CNContactThumbnailImageDataKey]
            
            self.contacts = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        } catch {
            print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .None
        self.tableView.backgroundColor = UIColor.init(red: 214/255, green: 238/255, blue: 255/255, alpha: 1.0)
        
        getContacts()
        
        for contact in contacts { // gets contacts with address
            if contact.isKeyAvailable(CNContactPostalAddressesKey) {
                let new_contact = Contact(name: "", city: City())
                if let addr = contact.postalAddresses.first?.value as? CNPostalAddress {
                    let city = City()
                    city.zipcode = addr.postalCode
                    city.country = addr.country
                    city.state = addr.state
                    city.name = addr.city
                    new_contact.city = city
                    new_contact.name = CNContactFormatter().stringFromContact(contact)!
                    if let image = contact.thumbnailImageData {
                        new_contact.image = UIImage(data:image)!
                    }
                    contacts_addr.append(new_contact)
                }
            }
            
        }
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var i:Int = 0
            while (i < self.contacts_addr.count) {
                self.ows.cityWeatherByZipcode(self.contacts_addr[i].city) {
                    (city) in
                        self.city1.append(city)
                        //print("name: \(city.name)     temp: \(city.currentTemp_F)")
                        self.tableView.reloadData()
                }
                i += 1
            }
        }
        
        changeWeather(self.city1)
    }
    
    func changeWeather(updatedCities: [City]) {
        var index:Int = 0
        for city in updatedCities {
            contacts_addr[index].city.barometricPressure = city.barometricPressure
            contacts_addr[index].city.coordinates = city.coordinates
            contacts_addr[index].city.country = city.country
            contacts_addr[index].city.currentTemp_F = city.currentTemp_F
            contacts_addr[index].city.currentTemp_C = city.currentTemp_C
            contacts_addr[index].city.currentTemp_K = city.currentTemp_K
            contacts_addr[index].city.description = city.description
            contacts_addr[index].city.humidity = city.humidity
            contacts_addr[index].city.maxTemp_F = city.maxTemp_F
            contacts_addr[index].city.minTemp_F = city.minTemp_F
            contacts_addr[index].city.maxTemp_C = city.maxTemp_C
            contacts_addr[index].city.minTemp_C = city.minTemp_C
            contacts_addr[index].city.maxTemp_K = city.maxTemp_K
            contacts_addr[index].city.minTemp_K = city.minTemp_K
            contacts_addr[index].city.name = city.name
            contacts_addr[index].city.clouds = city.clouds
            contacts_addr[index].city.state = city.state
            contacts_addr[index].city.sunrise = city.sunrise
            contacts_addr[index].city.sunset = city.sunset
            contacts_addr[index].city.windDirection = city.windDirection
            contacts_addr[index].city.windSpeed = city.windSpeed
            contacts_addr[index].city.zipcode = city.zipcode
            
            index += 1
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts_addr.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath)
        
        let contact = self.contacts_addr[indexPath.row]
        
        if let contactCell = cell as? ContactTableViewCell {
            
            contactCell.nameLabel.text = contact.name
            contactCell.addressLabel.text = "\(contact.city.name), \(contact.city.state)"
            contactCell.contactImage.image = contact.image
            contactCell.detailLabel.text = contact.city.detail
            contactCell.selectionStyle = UITableViewCellSelectionStyle.None
            
            // check settings for temperature units
            if (settings.units == .Kelvin) {
                contactCell.degreeLabel.text = "\(Int(contact.city.currentTemp_K))\u{00B0}"
            }
            else if (settings.units == .Celsius) {
                contactCell.degreeLabel.text = "\(Int(contact.city.currentTemp_C))\u{00B0}"
            }
            else {
                contactCell.degreeLabel.text = "\(Int(contact.city.currentTemp_F))\u{00B0}"
            }

            // check city's weather to get corresponding image
            if (contact.city.description == "Clouds") {
                contactCell.backgroundImage.image = UIImage(named: "Cloud_contact")
            }
            else if (contact.city.description == "Snow") {
                contactCell.backgroundImage.image = UIImage(named: "Snow_contact")
            }
            else if (contact.city.description == "Thunderstorm") {
                contactCell.backgroundImage.image = UIImage(named: "Storm_contact")
            }
            else if (contact.city.description == "Rain" || contact.city.description == "Drizzle") {
                contactCell.backgroundImage.image = UIImage(named: "Rain_contact")
            }
            else {
                contactCell.backgroundImage.image = UIImage(named: "Clear_contact")
            }
            
        }
        
        return cell
    }


}
