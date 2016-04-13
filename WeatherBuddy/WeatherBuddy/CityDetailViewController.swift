//
//  CityDetailViewController.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/5/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {

    var city : City?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "\(city!.name), \(city!.state)"
        iconImage.image = city?.icon
        detailLabel.text = city?.detail
        zipLabel.text = city?.zipcode
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
