//
//  vignetteView.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 5/1/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class VignetteView: UIView {

    //1 - the properties for the gradient
    @IBInspectable var startColor: UIColor = UIColor.whiteColor()
    @IBInspectable var endColor: UIColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.0)
    
    override func drawRect(rect: CGRect) {
        
        addGradient()
        
       /* //2 - get the current context
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor, endColor.CGColor]
        
        //3 - set up the color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //4 - set up the color stops
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        //5 - create the gradient
        let gradient = CGGradientCreateWithColors(colorSpace,
                                                  colors,
                                                  colorLocations)
        
        //6 - draw the gradient
        let startPoint:CGPoint = CGPoint(x:0, y:0)
        let endPoint:CGPoint = CGPoint(x:0, y:self.bounds.height)

        CGContextDrawLinearGradient(context,
                                    gradient,
                                    startPoint,
                                    endPoint,
                                    CGGradientDrawingOptions(rawValue: 0))
        */
    }
    
    func addGradient() {
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.frame.size
        //gradient.colors = [UIColor.whiteColor().CGColor,UIColor.whiteColor().colorWithAlphaComponent(0).CGColor]
        gradient.colors = [UIColor.whiteColor().CGColor,UIColor.clearColor()]
        self.layer.addSublayer(gradient)
    }



}
