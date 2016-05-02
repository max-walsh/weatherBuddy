//
//  AddCityViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/5/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController, UITextFieldDelegate {

    var cities: FavoriteCities?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!    
    @IBOutlet weak var stateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zipTextField.delegate = self
        zipTextField.keyboardType = UIKeyboardType.NumberPad
        imageView.image = UIImage(named: "City")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButton(sender: AnyObject) {
        
        // check that all text fields are filled in
        if (zipTextField.text == "" || cityTextField.text == "" || stateTextField.text == "") {
            let alert = UIAlertController(title: "Empty Field", message: "You must fill in all text fields.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
            
        // check that the zipcode is 5 numbers
        else if (zipTextField.text!.characters.count != 5) {
            let alert = UIAlertController(title: "Invalid Zipcode", message: "Please enter a 5 digit zipcode.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
            
        // check that the state is 2 letters
        else if (stateTextField.text!.characters.count != 2) {
            let alert = UIAlertController(title: "Invalid State", message: "Please enter a 2 letter state abbreviation.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
            
        // add the city
        else {
            cities?.addCity(cityTextField.text!, state: stateTextField.text!, zip: zipTextField.text!)
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }

}
