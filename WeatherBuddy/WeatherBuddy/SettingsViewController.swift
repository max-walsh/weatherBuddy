//
//  SettingsViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/28/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var themePickerView: UIPickerView!
    @IBOutlet weak var degreePickerView: UIPickerView!

    var themePickerDataSource = ["Classic", "Dogs", "Notre Dame"]
    var degreePickerDataSource = ["Fahrenheit", "Celsius", "Kelvin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.themePickerView.dataSource = self
        self.themePickerView.delegate = self
        self.degreePickerView.dataSource = self
        self.degreePickerView.delegate = self
        
        self.backgroundImage.image = UIImage(named: "Theme_c")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == themePickerView) {
            return themePickerDataSource.count
        }
        else {
            return degreePickerDataSource.count
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == themePickerView) {
            return themePickerDataSource[row]
        }
        else {
            return degreePickerDataSource[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (pickerView == themePickerView) {
            if(row == 0) {
                settings.theme = .Classic
                backgroundImage.image = UIImage(named: "Theme_c")
            }
            else if(row == 1) {
                settings.theme = .Dogs
                backgroundImage.image = UIImage(named: "Theme_dog")
            }
            else if(row == 2) {
                settings.theme = .NotreDame
                backgroundImage.image = UIImage(named: "Theme_nd")
            }
        }
        else {
            if(row == 0) {
                settings.units = .Fahrenheit
            }
            else if(row == 1) {
                settings.units = .Celsius
            }
            else if(row == 2) {
                settings.units = .Kelvin
            }
        }

    }
    
    // This function is for changing the font of the pickerViews
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        
        if (pickerLabel == nil) {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Tamil Sangam MN", size: 20)
            pickerLabel?.textAlignment = NSTextAlignment.Center
        }
        
        if (pickerView == themePickerView) {
            pickerLabel?.text = themePickerDataSource[row]
        }
        else {
            pickerLabel?.text = degreePickerDataSource[row]
        }
        
        return pickerLabel!
    }


}
