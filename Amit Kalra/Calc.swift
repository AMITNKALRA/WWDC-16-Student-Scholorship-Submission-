//
//  Calc.swift
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

class Calc: UIViewController, MKMapViewDelegate, NSUserActivityDelegate {
    
    //    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var blurredEfect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
    
    //This is putting the Blur Effect into the image.
    
    var blurredView = UIVisualEffectView(effect : UIBlurEffect())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Spotlight API
        
        let calc : NSUserActivity = NSUserActivity(activityType: "com.amitnkalra.Calc") // This is for spotlight.
        
        calc.title = "6284 Calc" // This will be the title displayed.
        calc.keywords = ["6284 Calc"] // These keywords are there to get there.
        calc.eligibleForSearch = true // This makes it able to be searched for.
        calc.eligibleForPublicIndexing = true // This makes it able to be searched for.
        calc.becomeCurrent() // This makes it current.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displaySearchResult:", name: "DisplaySearchResult2.1", object: nil) // This is used for the App Delegate.
        
        showSpotlight() // This calls the function.
        
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0)
        
        // Measures the storyboards size so it runs on the following device.
        
        //        blurredView.frame = backgroundImage.bounds
        
        //Adds the blur effect to the image.
        
        //        backgroundImage.addSubview(blurredView)
        
    }
    
    var searchMathIndex : Int!
    
    func displaySearchResult(notification : NSNotification) { // This helps display Spotlight.
        
        searchMathIndex = (notification.object as! NSString).integerValue
        
    }
    
    var uniqueIndentifier = 2.1
    
    func showSpotlight() { // This makes it display in spotlight.
        
        let searchCalc = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchCalc.title = "6284 Calc" // This will be the title displayed.
        searchCalc.keywords = ["6284 Calc"] // These keywords are there to get there.
        searchCalc.contentDescription = "This is about Amit's app." // This is the description that will be displayed.
        
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: "\(uniqueIndentifier)", domainIdentifier: "com.amitnkalra.Calc", attributeSet: searchCalc) // For App Delegate
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchableItem]) { // Error
            
            (error : NSError?) -> Void in
            
            if error != nil {
                
                print(error?.localizedDescription)
            }
        }
    }

    
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
            let audioURL = NSBundle.mainBundle().URLForResource("Calc", withExtension: "mp3"),
            let player = try? AVAudioPlayer(contentsOfURL: audioURL)
            
            else { fatalError("Unable to create player") }
        self.audioPlayer = player
        player.play()
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
    
    
    @IBAction func Calc(sender: AnyObject) {
        
        if let AmiCalc = NSURL(string: "https://itunes.apple.com/us/app/6284-calc/id1006996600?mt=8") {
            UIApplication.sharedApplication().openURL(AmiCalc)
        }
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
