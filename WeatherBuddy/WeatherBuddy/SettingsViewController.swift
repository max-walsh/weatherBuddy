//
//  SettingsViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/28/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                print("Classic")
            }
            else if(row == 1) {
                print("Dogs")
            }
            else if(row == 3) {
                print("Cats")
            }
        }
        else {
            if(row == 0) {
                print("F")
            }
            else if(row == 1) {
                print("C")
            }
            else if(row == 3) {
                print("K")
            }
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
