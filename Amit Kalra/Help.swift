//
//  Help.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/19/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit
import AVFoundation
import CoreSpotlight
import MobileCoreServices

class HelpViewController: UIViewController, NSUserActivityDelegate {
    
    @IBOutlet weak var menuBackgroundImage: UIImageView!
    
    @IBOutlet weak var howTo: UIWebView!
    
    var blurredView = UIVisualEffectView(effect : UIBlurEffect())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Spotlight API
        
        let help : NSUserActivity = NSUserActivity(activityType: "com.amitnkalra.Help") // This is for spotlight.
        
        help.title = "Help" // This will be the title displayed.
        help.keywords = ["Help"] // These keywords are there to get there.
        help.eligibleForSearch = true // This makes it able to be searched for.
        help.eligibleForPublicIndexing = true // This makes it able to be searched for.
        help.becomeCurrent() // This makes it current.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displaySearchResult:", name: "DisplaySearchResult4.2", object: nil) // This is used for the App Delegate.
        
        showSpotlight() // This calls the function.
        
        // Measures the storyboards size so it runs on the following device.
        
        blurredView.frame = menuBackgroundImage.bounds
        
        //Adds the blur effect to the image.
        
        menuBackgroundImage.addSubview(blurredView)
        
        let instruction = "https://www.youtube.com/watch?v=2JnI8qE-LKs"
        
        howTo.allowsInlineMediaPlayback = true
        howTo.loadHTMLString("<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/2JnI8qE-LKs/?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        
    }
    
    var searchMathIndex : Int!
    
    func displaySearchResult(notification : NSNotification) { // This helps display Spotlight.
        
        searchMathIndex = (notification.object as! NSString).integerValue
        
    }
    
    var uniqueIndentifier = 4.2
    
    func showSpotlight() { // This makes it display in spotlight.
        
        let searchHelp = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchHelp.title = "Help" // This will be the title displayed.
        searchHelp.keywords = ["Help"] // These keywords are there to get there.
        searchHelp.contentDescription = "This will help you." // This is the description that will be displayed.
        
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: "\(uniqueIndentifier)", domainIdentifier: "com.amitnkalra.Help", attributeSet: searchHelp) // For App Delegate
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchableItem]) { // Error
            
            (error : NSError?) -> Void in
            
            if error != nil {
                
                print(error?.localizedDescription)
            }
        }
    }

    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
        
        let noAlerts = NSUserDefaults.standardUserDefaults() //I like to shorten it a little, it makes my code more readable
        
        if !noAlerts.boolForKey("ripHelpAlert") {
            //showPopup
            
            let welcomeAlert = UIAlertController(title: "Not sure how to use my app?!", message: "Watch the video below on how to use and and view every feature!", preferredStyle: UIAlertControllerStyle.Alert)
            welcomeAlert.addAction(UIAlertAction(title: "OK.", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(welcomeAlert, animated: true, completion: nil)
            
            noAlerts.setBool(true, forKey: "ripHelpAlert")
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
        } else {
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Swipe Back Gesture
    
    @IBAction func SWIPE(sender: AnyObject) {
        
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
        
    } 
}