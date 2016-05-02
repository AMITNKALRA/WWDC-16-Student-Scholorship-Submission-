//
//  Backstory.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/19/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit
import MapKit
import AVFoundation
import CoreSpotlight
import MobileCoreServices

class Backstory: UIViewController, MKMapViewDelegate, NSUserActivityDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    //This is decaring what type of Blur Effect.
    
    var blurredEfect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
    
    //This is putting the Blur Effect into the image.
    
    var blurredView = UIVisualEffectView(effect : UIBlurEffect())
    
    private var audioPlayer: AVAudioPlayer? {
        didSet {
            
        }
    }
    
    private func playReadOver() {
        // Set up the audio session
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            fatalError("Unable to set the audio session because: \(error)")
        }
        
        guard
            let audioURL = NSBundle.mainBundle().URLForResource("Backstory", withExtension: "mp3"),
            let player = try? AVAudioPlayer(contentsOfURL: audioURL)
            
            else { fatalError("Unable to create player") }
        self.audioPlayer = player
        player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Spotlight API
        
        let backstory : NSUserActivity = NSUserActivity(activityType: "com.amitnkalra.Backstory") // This is for spotlight.
        
        backstory.title = "Backstory" // This will be the title displayed.
        backstory.keywords = ["Backstory"] // These keywords are there to get there.
        backstory.eligibleForSearch = true // This makes it able to be searched for.
        backstory.eligibleForPublicIndexing = true // This makes it able to be searched for.
        backstory.becomeCurrent() // This makes it current.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displaySearchResult:", name: "DisplaySearchResult1.4", object: nil) // This is used for the App Delegate.
        
        showSpotlight() // This calls the function.
        
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0)
        
    }
    
    var searchMathIndex : Int!
    
    func displaySearchResult(notification : NSNotification) { // This helps display Spotlight.
        
        searchMathIndex = (notification.object as! NSString).integerValue
        
    }
    
    var uniqueIndentifier = 1.4
    
    func showSpotlight() { // This makes it display in spotlight.
        
        let searchBackstory = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchBackstory.title = "Backstory" // This will be the title displayed.
        searchBackstory.keywords = ["Backstory", "About Amit"] // These keywords are there to get there.
        searchBackstory.contentDescription = "This is about Amit's background." // This is the description that will be displayed.
        
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: "\(uniqueIndentifier)", domainIdentifier: "com.amitnkalra.Backstory", attributeSet: searchBackstory) // For App Delegate
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchableItem]) { // Error
            
            (error : NSError?) -> Void in
            
            if error != nil {
                
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
                playReadOver()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        audioPlayer?.pause()
        
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
    
    @IBAction func SWIPE2(sender: AnyObject) {
        
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
        
    }
    
    @IBAction func SWIPE3(sender: AnyObject) {
        
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
        
    }
    
    @IBAction func SWIPE4(sender: AnyObject) {
        
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
        
    }
    
}