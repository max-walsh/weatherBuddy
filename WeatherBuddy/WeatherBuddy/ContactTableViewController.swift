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
    var tempCity = [City]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .None
        self.tableView.backgroundColor = UIColor.init(red: 214/255, green: 238/255, blue: 255/255, alpha: 1.0)
        
        getContacts() // fetch all contacts in phone
        
        for contact in contacts { // gets contacts with address
            if (contact.isKeyAvailable(CNContactPostalAddressesKey)) {
                let newContact = Contact(name: "", city: City())
                if let addr = contact.postalAddresses.first?.value as? CNPostalAddress {
                    if (checkZipcode(addr.postalCode)) { // checks if zip code is valid
                        let city = City()
                        city.zipcode = addr.postalCode
                        city.country = addr.country
                        city.state = addr.state
                        city.name = addr.city
                        newContact.city = city
                        newContact.name = CNContactFormatter().stringFromContact(contact)!
                        if let image = contact.thumbnailImageData {
                            newContact.image = UIImage(data:image)!
                        }
                        contacts_addr.append(newContact)
                    }
                }
            }
        }
        
        // gets weather for each contact's city
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var i = 0
            while (i < self.contacts_addr.count) {
                self.ows.cityWeatherByZipcode(self.contacts_addr[i].city) {
                    (city) in
                        self.tempCity.append(city)
                        self.tableView.reloadData()
                }
                i += 1
            }
        }
        changeWeather(self.tempCity)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
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
            
            // check settings for correct temperature units
            if (settings.units == .Kelvin) {
                contactCell.degreeLabel.text = "\(Int(contact.city.currentTemp_K))\u{00B0}"
            } else if (settings.units == .Celsius) {
                contactCell.degreeLabel.text = "\(Int(contact.city.currentTemp_C))\u{00B0}"
            } else {
                contactCell.degreeLabel.text = "\(Int(contact.city.currentTemp_F))\u{00B0}"
            }

            // check city's weather to get corresponding image for background
            if (contact.city.description == "Clouds") {
                contactCell.backgroundImage.image = UIImage(named: "Cloud_contact")
            } else if (contact.city.description == "Snow") {
                contactCell.backgroundImage.image = UIImage(named: "Snow_contact")
            } else if (contact.city.description == "Thunderstorm") {
                contactCell.backgroundImage.image = UIImage(named: "Storm_contact")
            } else if (contact.city.description == "Rain" || contact.city.description == "Drizzle") {
                contactCell.backgroundImage.image = UIImage(named: "Rain_contact")
            } else {
                contactCell.backgroundImage.image = UIImage(named: "Clear_contact")
            }
            
        }
        
        return cell
    }
    
    // functions for retrieving contacts
    func getContacts() {
        
        let store = CNContactStore()
        // checks if authorized to access contacts
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
        
        do { // retrieves contacts while requesting specific keys, like address and image
            let containerId = CNContactStore().defaultContainerIdentifier()
            let predicate: NSPredicate = CNContact.predicateForContactsInContainerWithIdentifier(containerId)
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactEmailAddressesKey, CNContactPostalAddressesKey, CNContactImageDataKey, CNContactImageDataAvailableKey, CNContactThumbnailImageDataKey]
            // store info into contacts array
            self.contacts = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        } catch {
            print(error)
        }
    }
    
    // function checks if a contact's zip code is valid
    func checkZipcode(zip: String) -> Bool {
        
        if (zip == "") { // no zip entered
            return false
        } else if (zip.characters.count != 5) { // not 5 characters
            return false
        } else if (Int(zip) == nil) { // not 5 integers
            return false
        } else {
            return true
        }
    }
    
    
    func changeWeather(updatedCities: [City]) {
        
        var index = 0
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

}
