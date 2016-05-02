//
//  DubDub.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/19/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import CoreSpotlight

class WWDC: UIViewController, NSUserActivityDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var finalWord: UIWebView!
    
    @IBOutlet weak var menuBackgroundImage: UIImageView!
        
    @IBAction func SWIPE(sender: AnyObject) {
        
        if let navController = self.navigationController {
            
            navController.popViewControllerAnimated(true)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Spotlight API
        
        let dubdub : NSUserActivity = NSUserActivity(activityType: "com.amitnkalra.DubDub") // This is for spotlight.
        
        dubdub.title = "WWDC" // This will be the title displayed.
        dubdub.keywords = ["WWDC", "Dub Dub"] // These keywords are there to get there.
        dubdub.eligibleForSearch = true // This makes it able to be searched for.
        dubdub.eligibleForPublicIndexing = true // This makes it able to be searched for.
        dubdub.becomeCurrent() // This makes it current.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displaySearchResult:", name: "DisplaySearchResult4.1", object: nil) // This is used for the App Delegate.
        
        showSpotlight() // This calls the function.
        
        let myFinalWord = "https://www.youtube.com/watch?v=V742ZhFZnrU"
        
        finalWord.allowsInlineMediaPlayback = true
        finalWord.loadHTMLString("<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/V742ZhFZnrU/?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    var uniqueIndentifier = 4.1
    
    func showSpotlight() { // This makes it display in spotlight.
        
        let searchDub = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchDub.title = "WWDC" // This will be the title displayed.
        searchDub.keywords = ["Dub Dub", "WWDC"] // These keywords are there to get there.
        searchDub.contentDescription = "This is why Amit wants to go to WWDC." // This is the description that will be displayed.
        
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: "\(uniqueIndentifier)", domainIdentifier: "com.amitnkalra.DubDub", attributeSet: searchDub) // For App Delegate
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchableItem]) { // Error
            
            (error : NSError?) -> Void in
            
            if error != nil {
                
                print(error?.localizedDescription)
            }
        }
    }

    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func WWDC(sender: AnyObject) {
        
        if let DubDub = NSURL(string: "https://developer.apple.com/wwdc/") {
            
            UIApplication.sharedApplication().openURL(DubDub)
        }
    }
    
    @IBAction func HAIRFORCE(sender: AnyObject) {
        
        if let hairForceOne = NSURL(string: "http://www.apple.com/pr/bios/craig-federighi.html") {
            UIApplication.sharedApplication().openURL(hairForceOne)
        }
    }
}