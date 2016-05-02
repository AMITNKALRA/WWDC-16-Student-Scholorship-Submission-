//
//  Projects.swift
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

class Projects: UIViewController, MKMapViewDelegate, NSUserActivityDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Spotlight API
        
        let projects : NSUserActivity = NSUserActivity(activityType: "com.amitnkalra.Projects") // This is for spotlight.
        
        projects.title = "Projects" // This will be the title displayed.
        projects.keywords = ["Projects"] // These keywords are there to get there.
        projects.eligibleForSearch = true // This makes it able to be searched for.
        projects.eligibleForPublicIndexing = true // This makes it able to be searched for.
        projects.becomeCurrent() // This makes it current.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displaySearchResult:", name: "DisplaySearchResult2", object: nil) // This is used for the App Delegate.
        
        showSpotlight() // This calls the function.

        
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        //Animated Picture
        
        AnimatedPicture.layer.masksToBounds = true
        AnimatedPicture.image = images[index++]
        animateAnimatedPicture()
        
    }
    
    var searchMathIndex : Int!
    
    func displaySearchResult(notification : NSNotification) { // This helps display Spotlight.
        
        searchMathIndex = (notification.object as! NSString).integerValue
        
    }
    
    var uniqueIndentifier = 2
    
    func showSpotlight() { // This makes it display in spotlight.
        
        let searchProjects = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchProjects.title = "Projects" // This will be the title displayed.
        searchProjects.keywords = ["Projects"] // These keywords are there to get there.
        searchProjects.contentDescription = "This is about Amit's Projects." // This is the description that will be displayed.
        
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: "\(uniqueIndentifier)", domainIdentifier: "com.amitnkalra.Projects", attributeSet: searchProjects) // For App Delegate
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchableItem]) { // Error
            
            (error : NSError?) -> Void in
            
            if error != nil {
                
                print(error?.localizedDescription)
            }
        }
    }

    
    @IBOutlet var AnimatedPicture: UIImageView!
    
    let images = [
        
        UIImage(named: "Advertisment.png")!,
        
        UIImage(named: "FactsBanner.png")!,
        
        UIImage(named: "Quad.jpg")!,
        
        UIImage(named: "thinking.JPG")!]
    
    var index = 0
    let animationDuration: NSTimeInterval = 0.25
    let switchingInterval: NSTimeInterval = 1.5
    
    //Animated Picture
    
    func animateAnimatedPicture() {
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(self.switchingInterval * NSTimeInterval(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.animateAnimatedPicture()
            }
        }
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        /*
         transition.type = kCATransitionPush
         transition.subtype = kCATransitionFromRight
         */
        AnimatedPicture.layer.addAnimation(transition, forKey: kCATransition)
        AnimatedPicture.image = images[index]
        
        CATransaction.commit()
        
        index = index < images.count - 1 ? index + 1 : 0
    }
    
    let backgroundImages = [
        
        UIImage(named: "testblur.png")!,
        
        UIImage(named: "flowerBlur.png")!,
        
        UIImage(named: "testblurthree.png")!,
        
        UIImage(named: "testblurfour.png")!]
    
    var backgroundIndex = 0
    let backgroundAnimationDuration: NSTimeInterval = 0.25
    let backgroundSwitchingInterval: NSTimeInterval = 1.5
    
    //Animated Background
    
    func animateBackground() {
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(backgroundAnimationDuration)
        CATransaction.setCompletionBlock {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(self.backgroundSwitchingInterval * NSTimeInterval(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.animateBackground()
            }
        }
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        /*
         transition.type = kCATransitionPush
         transition.subtype = kCATransitionFromRight
         */
        backgroundImage.layer.addAnimation(transition, forKey: kCATransition)
        backgroundImage.image = backgroundImages[backgroundIndex]
        
        CATransaction.commit()
        
        backgroundIndex = backgroundIndex < backgroundImages.count - 1 ? backgroundIndex + 1 : 0
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
            let audioURL = NSBundle.mainBundle().URLForResource("Projects", withExtension: "mp3"),
            let player = try? AVAudioPlayer(contentsOfURL: audioURL)
            
            else { fatalError("Unable to create player") }
        self.audioPlayer = player
        player.play()
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
        //        playReadOver()
        
        backgroundImage.layer.masksToBounds = true
        backgroundImage.image = backgroundImages[backgroundIndex++]
        animateBackground()
        
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
}