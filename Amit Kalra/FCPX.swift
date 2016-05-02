//
//  FCPX.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/19/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit
import AVFoundation
import CoreSpotlight
import MobileCoreServices

class FCPX: UIViewController, NSUserActivityDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var blurredEfect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
    
    //This is putting the Blur Effect into the image.
    
    var blurredView = UIVisualEffectView(effect : UIBlurEffect())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0)
        
        // Measures the storyboards size so it runs on the following device.
        
        //        blurredView.frame = backgroundImage.bounds
        
        //Adds the blur effect to the image.
        
        //        backgroundImage.addSubview(blurredView)
        
        // Spotlight API
        
        let FCPX : NSUserActivity = NSUserActivity(activityType: "com.amitnkalra.FCPX") // This is for spotlight.
        
        FCPX.title = "Final Cut Pro X" // This will be the title displayed.
        FCPX.keywords = ["Final Cut Pro X", "Experience"] // These keywords are there to get there.
        FCPX.eligibleForSearch = true // This makes it able to be searched for.
        FCPX.eligibleForPublicIndexing = true // This makes it able to be searched for.
        FCPX.becomeCurrent() // This makes it current.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displaySearchResult:", name: "DisplaySearchResult3.4", object: nil) // This is used for the App Delegate.
        
        showSpotlight() // This calls the function.
        
    }
    
    var searchMathIndex : Int!
    
    func displaySearchResult(notification : NSNotification) { // This helps display Spotlight.
        
        searchMathIndex = (notification.object as! NSString).integerValue
        
    }
    
    var uniqueIndentifier = 3.4
    
    func showSpotlight() { // This makes it display in spotlight.
        
        let searchFCPX = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchFCPX.title = "Final Cut Pro X" // This will be the title displayed.
        searchFCPX.keywords = ["Final Cut Pro X", "Experience"] // These keywords are there to get there.
        searchFCPX.contentDescription = "This is about Amit's experience on Final Cut Pro X." // This is the description that will be displayed.
        
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: "\(uniqueIndentifier)", domainIdentifier: "com.amitnkalra.FCPX", attributeSet: searchFCPX) // For App Delegate
        
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
            let audioURL = NSBundle.mainBundle().URLForResource("FCPX", withExtension: "mp3"),
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
    
    @IBAction func FCPX(sender: AnyObject) {
        
        if let download = NSURL(string: "https://itunes.apple.com/us/app/final-cut-pro/id424389933?mt=12") {
            UIApplication.sharedApplication().openURL(download)
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
    
}