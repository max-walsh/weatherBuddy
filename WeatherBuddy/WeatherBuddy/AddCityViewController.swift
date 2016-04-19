//
//  AddCityViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/5/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController, UITextFieldDelegate {

    var cities : FavoriteCities?
    
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!    
    @IBOutlet weak var stateTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zipTextField.delegate = self
        zipTextField.keyboardType = UIKeyboardType.NumberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButton(sender: AnyObject) {
        if (zipTextField.text == "" || cityTextField.text == "" || stateTextField.text == "") {
            let alert = UIAlertController(
                title: "Empty Field", message: "You must fill in all text fields.", preferredStyle: .Alert)
            let action = UIAlertAction(
                title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
        let zip:String = zipTextField.text!
        zip.characters.count
        if (zipTextField.text!.characters.count != 5) {
            let alert = UIAlertController(title: "Invalid Zipcode", message: "Please enter a 5 digit zipcode.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
        cities?.addCity(cityTextField.text!, state: stateTextField.text!, zip: zipTextField.text!)
        
        dismissViewControllerAnimated(true, completion: nil)
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
