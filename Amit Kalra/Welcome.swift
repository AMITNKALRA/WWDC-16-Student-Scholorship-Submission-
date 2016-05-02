//
//  Welcome.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/19/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit

extension UIImage {
    func imageScaledToSize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.drawInRect(CGRect(origin: CGPointZero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

class Sliding: UILabel {
    
    var timer:NSTimer = NSTimer()
    var currentCharacter:Int = 0
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addLayerWithAnim()
    }
    
    func addLayerWithAnim () {
        
        let maskLayer = CALayer()
        
        maskLayer.backgroundColor = UIColor(white: 0.0, alpha: 0.53).CGColor
        maskLayer.frame = CGRectMake(0.0, 0.0, self.frame.size.width * 4, self.frame.size.height)
        maskLayer.contents = UIImage(named: "spark-mask.png")?.imageScaledToSize(CGSize(width: self.frame.height, height: self.frame.height)).CGImage
        maskLayer.contentsGravity = kCAGravityCenter
        maskLayer.position.x = -self.frame.size.width/2
        let maskAnim:CABasicAnimation = CABasicAnimation(keyPath: "position.x")
        maskAnim.byValue = NSNumber(float: Float(self.frame.size.width * 2))
        maskAnim.repeatCount = Float.infinity
        maskAnim.duration = 2
        maskAnim.removedOnCompletion = false
        maskLayer.addAnimation(maskAnim, forKey: "slideAnim")
        
        self.layer.mask = maskLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        addLayerWithAnim()
        
    }
}