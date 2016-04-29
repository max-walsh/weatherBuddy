//
//  GradientView.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/29/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    //1 - the properties for the gradient
    @IBInspectable var startColor: UIColor = UIColor.blueColor()
    @IBInspectable var endColor: UIColor = UIColor.whiteColor()
    @IBInspectable var leftToRight = 0
    
    override func drawRect(rect: CGRect) {
        
        //2 - get the current context
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
        //let startPoint = CGPoint.zero
        //let endPoint = CGPoint(x:0, y:self.bounds.height)
        var startPoint:CGPoint
        var endPoint:CGPoint
        if (leftToRight == 0) {
            startPoint = CGPoint.zero
            endPoint = CGPoint(x:self.bounds.width, y:self.bounds.height)
            
        }
        else {
            endPoint = CGPoint.zero
            startPoint = CGPoint(x:self.bounds.width, y:self.bounds.height)
        }
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    startPoint,
                                    endPoint,
                                    CGGradientDrawingOptions(rawValue: 0))
    }
}
