//
//  Me.swift
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

class Me: UIViewController, MKMapViewDelegate, NSUserActivityDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var wasssUp: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //This is decaring what type of Blur Effect.
    
    var blurredEfect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
    
    //This is putting the Blur Effect into the image.
    
    var blurredView = UIVisualEffectView(effect : UIBlurEffect())
    
    @IBOutlet weak var baeView: MKMapView!
    
    @IBOutlet var profilePicture: UIImageView!
    
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
            let audioURL = NSBundle.mainBundle().URLForResource("Me", withExtension: "mp3"),
            let player = try? AVAudioPlayer(contentsOfURL: audioURL)
            
            else { fatalError("Unable to create player") }
        self.audioPlayer = player
        player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Spotlight API
        
        let me : NSUserActivity = NSUserActivity(activityType: "com.amitnkalra.Me") // This is for spotlight.
        
        me.title = "Me" // This will be the title displayed.
        me.keywords = ["Me"] // These keywords are there to get there.
        me.eligibleForSearch = true // This makes it able to be searched for.
        me.eligibleForPublicIndexing = true // This makes it able to be searched for.
        me.becomeCurrent() // This makes it current.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displaySearchResult:", name: "DisplaySearchResult1.1", object: nil) // This is used for the App Delegate.
        
        showSpotlight() // This calls the function.
        
        
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        
        //This makes the profile picture a circle.
        
        profilePicture.layer.cornerRadius = 100
        profilePicture.layer.masksToBounds = true
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderColor = UIColor.blueColor().CGColor
        
        //San Francisco
        
        var latitude : CLLocationDegrees = 37.5869
        var longitude : CLLocationDegrees = -122.0258
        
        var latitudeData : CLLocationDegrees = 0.99999000000000
        var longitudeData : CLLocationDegrees = 0.99999000000000
        
        var areaSpan : MKCoordinateSpan = MKCoordinateSpanMake(latitudeData, longitudeData)
        
        var SanFrancisco : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region : MKCoordinateRegion = MKCoordinateRegionMake(SanFrancisco, areaSpan)
        
        self.baeView.setRegion(region, animated: true)
        
        var baeAnnotation = MKPointAnnotation()
        
        baeAnnotation.coordinate = SanFrancisco
        
        baeAnnotation.title = "Union City, CA"
        baeAnnotation.subtitle = "I've lived here since I was 4!"
        
        self.baeView.addAnnotation(baeAnnotation)
        
    }
    
    var searchMathIndex : Int!
    
    func displaySearchResult(notification : NSNotification) { // This helps display Spotlight.
        
        searchMathIndex = (notification.object as! NSString).integerValue
        
    }
    
    var uniqueIndentifier = 1.1
    
    func showSpotlight() { // This makes it display in spotlight.
        
        let searchMe = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchMe.title = "Me" // This will be the title displayed.
        searchMe.keywords = ["Me", "About Amit"] // These keywords are there to get there.
        searchMe.contentDescription = "This is about Amit." // This is the description that will be displayed.
        
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: "\(uniqueIndentifier)", domainIdentifier: "com.amitnkalra.Me", attributeSet: searchMe) // For App Delegate
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchableItem]) { // Error
            
            (error : NSError?) -> Void in
            
            if error != nil {
                
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
    }
    // My Location
    
    func myCity() {
        
        var latitude : CLLocationDegrees = 37.5869
        
        var longitude : CLLocationDegrees = 122.0258
        
        var latitudeData : CLLocationDegrees = 0.99999000000000
        
        var longitudeData : CLLocationDegrees = 0.99999000000000
        
        var areaSpan : MKCoordinateSpan = MKCoordinateSpanMake(latitudeData, longitudeData)
        
        var unionCity : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region : MKCoordinateRegion = MKCoordinateRegionMake(unionCity, areaSpan)
        
        
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
    
    @IBAction func ucInfo(sender: AnyObject) {
        
        if let uc = NSURL(string: "https://en.wikipedia.org/wiki/Union_City,_California") {
            
            UIApplication.sharedApplication().openURL(uc)
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