//
//  FactsMe.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/24/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit
import MapKit
import CoreSpotlight
import MobileCoreServices

class FactsMe: UIViewController, MKMapViewDelegate, NSUserActivityDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let factBook = FactBook()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var theButton: UIButton!
    
    @IBOutlet weak var showFact: UILabel!
    
    @IBAction func getFact(sender: AnyObject) {
        
        showFact.text = factBook.genRandomFact()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        showFact.text = factBook.genRandomFact()

        theButton.layer.cornerRadius = 10
        
        // Spotlight API
        
        let factsMe : NSUserActivity = NSUserActivity(activityType: "com.amitnkalra.FactsMe") // This is for spotlight.
        
        factsMe.title = "Fun Facts" // This will be the title displayed.
        factsMe.keywords = ["Fun Facts"] // These keywords are there to get there.
        factsMe.eligibleForSearch = true // This makes it able to be searched for.
        factsMe.eligibleForPublicIndexing = true // This makes it able to be searched for.
        factsMe.becomeCurrent() // This makes it current.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displaySearchResult:", name: "DisplaySearchResult1.7", object: nil) // This is used for the App Delegate.
        
        showSpotlight() // This calls the function.
        
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        
        
    }
    
    var searchMathIndex : Int!
    
    func displaySearchResult(notification : NSNotification) { // This helps display Spotlight.
        
        searchMathIndex = (notification.object as! NSString).integerValue
        
    }
    
    var uniqueIndentifier = 1.7
    
    func showSpotlight() { // This makes it display in spotlight.
        
        let searchFactsMe = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchFactsMe.title = "Fun Facts" // This will be the title displayed.
        searchFactsMe.keywords = ["Fun Facts", "About Amit"] // These keywords are there to get there.
        searchFactsMe.contentDescription = "This is fun facts about Amit." // This is the description that will be displayed.
        
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: "\(uniqueIndentifier)", domainIdentifier: "com.amitnkalra.FactsMe", attributeSet: searchFactsMe) // For App Delegate
        
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
    
    //Swipe Back Gesture
    
    @IBAction func SWIPE(sender: AnyObject) {
        
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
            
        }
        
    }
    
    
}