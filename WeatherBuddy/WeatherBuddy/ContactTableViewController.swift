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
    var contacts = [CNContact]()
    var our_contacts = [Contact]()
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
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactEmailAddressesKey, CNContactPostalAddressesKey, CNContactImageDataKey, CNContactImageDataAvailableKey]
            
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
        for contact in contacts {
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
                    /*if contact.imageDataAvailable {
                        if let image = contact.imageData {
                            new_contact.image = UIImage(data: image)!
                        }
                    }*/
                    if let image = contact.imageData { new_contact.image = UIImage(data:image)! }
                    our_contacts.append(new_contact)
                }
            }
            
        }
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var i:Int = 0
            while (i < self.our_contacts.count) {
                self.ows.cityWeatherByZipcode(self.our_contacts[i].city) {
                    (city) in
                        self.city1.append(city)
                        print("name: \(city.name)     temp: \(city.currentTemp_F)")
                        self.tableView.reloadData()
                }
                i += 1
            }
        }
        
        changeWeather(self.city1)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func changeWeather(updatedCities: [City]) {
        var index:Int = 0
        for city in updatedCities {
            our_contacts[index].city.barometricPressure = city.barometricPressure
            our_contacts[index].city.coordinates = city.coordinates
            our_contacts[index].city.country = city.country
            our_contacts[index].city.currentTemp_F = city.currentTemp_F
            our_contacts[index].city.currentTemp_C = city.currentTemp_C
            our_contacts[index].city.currentTemp_K = city.currentTemp_K
            our_contacts[index].city.description = city.description
            our_contacts[index].city.humidity = city.humidity
            our_contacts[index].city.maxTemp_F = city.maxTemp_F
            our_contacts[index].city.minTemp_F = city.minTemp_F
            our_contacts[index].city.maxTemp_C = city.maxTemp_C
            our_contacts[index].city.minTemp_C = city.minTemp_C
            our_contacts[index].city.maxTemp_K = city.maxTemp_K
            our_contacts[index].city.minTemp_K = city.minTemp_K
            our_contacts[index].city.name = city.name
            our_contacts[index].city.clouds = city.clouds
            our_contacts[index].city.state = city.state
            our_contacts[index].city.sunrise = city.sunrise
            our_contacts[index].city.sunset = city.sunset
            our_contacts[index].city.windDirection = city.windDirection
            our_contacts[index].city.windSpeed = city.windSpeed
            our_contacts[index].city.zipcode = city.zipcode
            
            //print ("name: \(our_contacts[index].city.name)     temp: \(our_contacts[index].city.currentTemp_F)")
            index += 1
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return our_contacts.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath)
        
        let contact = self.our_contacts[indexPath.row]
        
        if let contactCell = cell as? ContactTableViewCell {
            contactCell.nameLabel.text = contact.name
            contactCell.addressLabel.text = "\(contact.city.name), \(contact.city.state)"
            contactCell.contactImage.image = contact.image
            if (settings.units == .Kelvin) {
                contactCell.degreeLabel.text = "\(Int(contact.city.currentTemp_K))\u{00B0}"
            }
            else if (settings.units == .Celsius) {
                contactCell.degreeLabel.text = "\(Int(contact.city.currentTemp_C))\u{00B0}"
            }
            else {
                contactCell.degreeLabel.text = "\(Int(contact.city.currentTemp_F))\u{00B0}"
            }
            contactCell.iconImage.image = contact.city.icon
            contactCell.detailLabel.text = contact.city.detail
            contactCell.selectionStyle = UITableViewCellSelectionStyle.None
            if (contact.city.description == "Clouds" || contact.city.description == "Rain") {
                contactCell.gradientView.clouds = 1
                contactCell.gradientView.setNeedsDisplay()
            }
            else {
                contactCell.gradientView.clouds = 0
                contactCell.gradientView.setNeedsDisplay()
            }
            contactCell.gradientView.leftToRight = (indexPath.row)%2
        }
        
        return cell
    }


}
