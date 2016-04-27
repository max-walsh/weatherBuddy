//
//  SunView.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/27/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit

class SunView: UIView {

    let π:CGFloat = CGFloat(M_PI)
    var counterColor: UIColor = UIColor.yellowColor()
    var dotColor: UIColor = UIColor.orangeColor()
    var rise:Int?
    var set:Int?
    var current=Int(NSDate().timeIntervalSince1970)
    var img = UIImage(named: "Sun")

    let dateFormatter = NSDateFormatter()
    
    override func drawRect(rect: CGRect) {
        //let current = rise!+(9*60*60)
        //print("rise: \(rise!)")
        //print("current: \(current)")
        //print("set: \(set!)")
        
        let total = set!-rise!
        let portion = current - rise!
        let frac = CGFloat(portion)/CGFloat(total)
        let arc_frac = (frac*π) + π
            
        print ("frac = \(frac)")
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        let radius: CGFloat = bounds.width - 17

        let arcWidth: CGFloat = 5

        let startAngle: CGFloat = π
        let endAngle: CGFloat = 2*π

        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
    
        if (current > rise && current < set) {
            let x = (cos(arc_frac)*(radius/2 - arcWidth/2)) + (bounds.width/2)
            let y = (bounds.height/2) + (sin(arc_frac)*(radius/2 - arcWidth/2))
            /*let center_dot = CGPoint(x: x, y: y)
            print ("x: \(x)")
            print ("y: \(y)")
            let radius_dot = 15.0
            let start:CGFloat = 0
            let end:CGFloat = 2*π
            let path_dot = UIBezierPath(arcCenter: center_dot,
                                    radius: CGFloat(radius_dot/2),
                                    startAngle: start,
                                    endAngle: end,
                                    clockwise: true)
        
            path_dot.lineWidth = 5
            dotColor.setStroke()
            path_dot.stroke()
            */
            let imageView = UIImageView(image: img!)
            imageView.frame = CGRect(x: x-15, y: y-15, width: 30, height: 30)
            self.addSubview(imageView)
        }

    }
}
