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
    var arcColor: UIColor = UIColor.yellowColor()
    var sunImg = UIImage(named: "Sun")
    let dateFormatter = NSDateFormatter()
    
    var riseTime: Int?
    var setTime: Int?
    var currentTime = Int(NSDate().timeIntervalSince1970)
    var timeZone: NSTimeZone?
    
    override func drawRect(rect: CGRect) {
        
        // account for the time zone of the city for the current time
        currentTime += timeZone!.secondsFromGMT + 14400
        
        // draw the arc
        let arcCenter = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = bounds.width - 17
        let arcWidth: CGFloat = 3
        let startAngle: CGFloat = π
        let endAngle: CGFloat = 2*π

        let path = UIBezierPath(arcCenter: arcCenter,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        arcColor.setStroke()
        path.stroke()
        
        // calculate current position of sun and place image
        let totalTime = setTime!-riseTime!
        let portion = currentTime - riseTime!
        let frac = CGFloat(portion)/CGFloat(totalTime)
        let arcFrac = (frac*π) + π
        
        if (currentTime > riseTime && currentTime < setTime) {
            let x = (cos(arcFrac)*(radius/2 - arcWidth/2)) + (bounds.width/2)
            let y = (bounds.height/2) + (sin(arcFrac)*(radius/2 - arcWidth/2))
            
            let imageView = UIImageView(image: sunImg!)
            imageView.frame = CGRect(x: x-15, y: y-15, width: 30, height: 30)
            
            self.addSubview(imageView)
        }

    }
}
