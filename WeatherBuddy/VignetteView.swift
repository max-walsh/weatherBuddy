//
//  vignetteView.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 5/1/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class VignetteView: UIView {

    override func drawRect(rect: CGRect) {
        
        // creates a gradient from top to bottom of light to dark
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.frame.size
        gradient.colors = [UIColor.whiteColor().CGColor, UIColor.clearColor()]
        self.layer.addSublayer(gradient)
    
    }

}
