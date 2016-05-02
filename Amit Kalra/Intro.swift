//
//  Intro.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/19/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var line3: UILabel!
    @IBOutlet weak var line4: UILabel!
    @IBOutlet weak var line5: UILabel!
    @IBOutlet weak var line6: UILabel!
    @IBOutlet weak var line7: UILabel!
    @IBOutlet weak var line8: UILabel!
    @IBOutlet weak var line9: UILabel!
    @IBOutlet weak var line10: UILabel!
    @IBOutlet weak var line11: UILabel!
    @IBOutlet weak var line12: UILabel!
    @IBOutlet weak var line13: UILabel!
    @IBOutlet weak var importantLine: UIButton!
    
    var labelMessages : [String] = ["let greetings = ['Hello!']", "greetings.append('Yo!')", "Waiting for the app to start?", "It'll start soon 😜", "Preparing..", "Thank you", "for allowing me to", "express my creativity!", "by making this app!", "Follow Me @AMITNKALRA", "Booting...", "Welcome to my app!", "Scroll down!"]
    var labels = [UILabel]()
    
    func theTexts() {
        
        let newArray = labelMessages.Shift(1)
        labelMessages = newArray
        
        for var i = 0; i < labels.count; i++ {
            
            let label = labels[i]
            label.text = labelMessages[i]
        }
        
        if line13.text == "Welcome to my app!" {
            
            importantLine.setTitle("Tap To Boot!", forState: .Normal)
            importantLine.hidden = false
        }
        
    }
    
    //    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        labels = [line1, line2, line3, line4, line5, line6, line7, line8, line9, line10, line11, line12, line13]
        
        for var i = 0; i < labels.count; i++ {
            
            // get the number of the label, this is line[i]
            // the set the text of the label to the message with the same index (from labelMessages)
            
            let label = labels[i]
            label.text = labelMessages[i]
            
        }
        
        
        
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "theTexts", userInfo: nil, repeats: true)
        
        theTexts()
        
        importantLine.hidden = true
        importantLine.setTitle("Tap To Begin!", forState: .Normal)
        
        //        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func awesomeFade(sender: AnyObject) {
        
        UIView.animateWithDuration(1.0, animations: ( {
            
            
            self.importantLine.transform = CGAffineTransformMakeScale(2000, 2000)
            
            
        }))
        
    }
    
    
}

extension Array {
    func Shift(shiftAmount:Int) -> Array {
        var array = Array()
        if (self.count > 0) {
            array = self
            if (shiftAmount > 0) {
                for _ in 1...shiftAmount {
                    array.append(array.removeAtIndex(0))
                }
            }
            else if (shiftAmount < 0) {
                for _ in 1...abs(shiftAmount) {
                    array.insert(array.removeAtIndex(array.count-1),atIndex:0)
                }
            }
        }
        return array
    }
}