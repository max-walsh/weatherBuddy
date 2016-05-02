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
        
        // set data sources and delegates for the picker views
        self.themePickerView.dataSource = self
        self.themePickerView.delegate = self
        self.degreePickerView.dataSource = self
        self.degreePickerView.delegate = self
        
        // set the initial row selected for themePicker
        if (settings.theme == .Dogs) {
            themePickerView.selectRow(1, inComponent: 0, animated: true)
            self.backgroundImage.image = UIImage(named: "Theme_dog")
        } else if (settings.theme == .NotreDame) {
            self.backgroundImage.image = UIImage(named: "Theme_nd")
            themePickerView.selectRow(2, inComponent: 0, animated: true)
        } else {
            self.backgroundImage.image = UIImage(named: "Theme_c")
            themePickerView.selectRow(0, inComponent: 0, animated: true)
        }
        
        // set the initial row selected for degreePicker
        if (settings.units == .Celsius) {
            degreePickerView.selectRow(1, inComponent: 0, animated: true)
        } else if (settings.units == .Kelvin) {
            degreePickerView.selectRow(2, inComponent: 0, animated: true)
        } else {
            degreePickerView.selectRow(0, inComponent: 0, animated: true)
        }
        
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
        } else {
            return degreePickerDataSource.count
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == themePickerView) {
            return themePickerDataSource[row]
        } else {
            return degreePickerDataSource[row]
        }
    }
    
    // function for when a setting is changed
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == themePickerView) {
            if(row == 0) {
                settings.theme = .Classic
                backgroundImage.image = UIImage(named: "Theme_c")
            } else if(row == 1) {
                settings.theme = .Dogs
                backgroundImage.image = UIImage(named: "Theme_dog")
            } else if(row == 2) {
                settings.theme = .NotreDame
                backgroundImage.image = UIImage(named: "Theme_nd")
            }
        } else {
            if(row == 0) {
                settings.units = .Fahrenheit
            } else if(row == 1) {
                settings.units = .Celsius
            } else if(row == 2) {
                settings.units = .Kelvin
            }
        }

    }
    
    // function for changing the font of the pickerViews
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        
        if (pickerLabel == nil) {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Tamil Sangam MN", size: 20)
            pickerLabel?.textAlignment = NSTextAlignment.Center
        }
        
        if (pickerView == themePickerView) {
            pickerLabel?.text = themePickerDataSource[row]
        } else {
            pickerLabel?.text = degreePickerDataSource[row]
        }
        
        return pickerLabel!
    }


}
