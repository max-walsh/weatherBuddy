//
//  AddCityViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/5/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {

    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addZip(sender: AnyObject) {
        if (zipTextField.text == "") {
            let alert = UIAlertController(
                title: "Empty Field", message: "You must enter a zip code.", preferredStyle: .Alert)
            let action = UIAlertAction(
                title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func addCity(sender: AnyObject) {
        if (cityTextField.text == "") {
            let alert = UIAlertController(
                title: "Empty Field", message: "You must enter a city and state.", preferredStyle: .Alert)
            let action = UIAlertAction(
                title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
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
