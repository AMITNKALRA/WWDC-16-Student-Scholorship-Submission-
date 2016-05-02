//
//  YouTube.swift
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

class YouTube: UIViewController, MKMapViewDelegate, NSUserActivityDelegate {
    
    //    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var finalWord: UIWebView!
    
    
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
        
        let myFinalWord = "https://www.youtube.com/watch?v=MLI9jvcJErw"
        
        finalWord.allowsInlineMediaPlayback = true
        finalWord.loadHTMLString("<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/MLI9jvcJErw/?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        
        // Spotlight API
        
        let youtube : NSUserActivity = NSUserActivity(activityType: "com.amitnkalra.YouTube") // This is for spotlight.
        
        youtube.title = "YouTube" // This will be the title displayed.
        youtube.keywords = ["YouTube"] // These keywords are there to get there.
        youtube.eligibleForSearch = true // This makes it able to be searched for.
        youtube.eligibleForPublicIndexing = true // This makes it able to be searched for.
        youtube.becomeCurrent() // This makes it current.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displaySearchResult:", name: "DisplaySearchResult2.4", object: nil) // This is used for the App Delegate.
        
        showSpotlight() // This calls the function.

        
    }
    
    var searchMathIndex : Int!
    
    func displaySearchResult(notification : NSNotification) { // This helps display Spotlight.
        
        searchMathIndex = (notification.object as! NSString).integerValue
        
    }
    
    var uniqueIndentifier = 2.4
    
    func showSpotlight() { // This makes it display in spotlight.
        
        let searchYouTube = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchYouTube.title = "YouTube" // This will be the title displayed.
        searchYouTube.keywords = ["YouTube"] // These keywords are there to get there.
        searchYouTube.contentDescription = "This is about Amit's YouTube channel." // This is the description that will be displayed.
        
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: "\(uniqueIndentifier)", domainIdentifier: "com.amitnkalra.YouTube", attributeSet: searchYouTube) // For App Delegate
        
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
            let audioURL = NSBundle.mainBundle().URLForResource("YouTube", withExtension: "mp3"),
            let player = try? AVAudioPlayer(contentsOfURL: audioURL)
            
            else { fatalError("Unable to create player") }
        self.audioPlayer = player
        player.play()
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
                playReadOver()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        audioPlayer?.pause()
        
    }
    
    @IBAction func YouTube(sender: AnyObject) {
        
        if let YT = NSURL(string: "https://www.youtube.com/user/AMITNKALRA") {
            UIApplication.sharedApplication().openURL(YT)
        }
        
    }
    
    //Swipe Back Gesture
    
    @IBAction func SWIPE(sender: AnyObject) {
        
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
        
    }
    
}