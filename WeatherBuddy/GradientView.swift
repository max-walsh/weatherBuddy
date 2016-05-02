//
//  GradientView.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/29/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = UIColor.blueColor()
    @IBInspectable var endColor: UIColor = UIColor.whiteColor()
    @IBInspectable var startColor_gray: UIColor = UIColor.grayColor()
    @IBInspectable var endColor_gray: UIColor = UIColor.whiteColor()
    
    @IBInspectable var leftToRight = 0 // determines direction of gradient
    @IBInspectable var clouds = 0 // determines color of gradient
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        var colors = [startColor.CGColor, endColor.CGColor]
        
        if (clouds == 1) {
            colors = [startColor_gray.CGColor, endColor_gray.CGColor]
            
        }
        
            let colorSpace = CGColorSpaceCreateDeviceRGB()
        
            let colorLocations:[CGFloat] = [0.0, 1.0]
            
            let gradient = CGGradientCreateWithColors(colorSpace,
                                                      colors,
                                                      colorLocations)
    
            var startPoint:CGPoint
            var endPoint:CGPoint
            if (leftToRight == 0) { // gradient draws left to right
                startPoint = CGPoint.zero
                endPoint = CGPoint(x:self.bounds.width, y:self.bounds.height)
                
            }
            else { // gradient draws right to left
                startPoint = CGPoint(x:self.bounds.width, y:self.bounds.height)
                endPoint = CGPoint.zero
            }
        
            CGContextDrawLinearGradient(context,
                                        gradient,
                                        startPoint,
                                        endPoint,
                                        CGGradientDrawingOptions(rawValue: 0))

    }
}
