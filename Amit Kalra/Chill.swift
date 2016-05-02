//
//  Chill.swift
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

class Chill: UIViewController, MKMapViewDelegate, NSUserActivityDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var hobbies: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var musicScroller: UIScrollView!
    
    @IBOutlet weak var showScroller: UIScrollView!
    
    @IBOutlet weak var AnimatedPicture: UIImageView!
    
    let images = [
        
        UIImage(named: "cityboy.png")!,
        
        UIImage(named: "dubaiboy.png")!,
                
        UIImage(named: "drivingboy.png")!,
                
        UIImage(named: "exploringboy.png")!,
        
        UIImage(named: "waterboy.png")!,
        
        UIImage(named: "iPhone Photography.JPG")!]
    
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
            let audioURL = NSBundle.mainBundle().URLForResource("Chill", withExtension: "mp3"),
            let player = try? AVAudioPlayer(contentsOfURL: audioURL)
            
            else { fatalError("Unable to create player") }
        self.audioPlayer = player
        player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Spotlight API
        
        let chill : NSUserActivity = NSUserActivity(activityType: "com.amitnkalra.Chill") // This is for spotlight.
        
        chill.title = "Chill" // This will be the title displayed.
        chill.keywords = ["Chill"] // These keywords are there to get there.
        chill.eligibleForSearch = true // This makes it able to be searched for.
        chill.eligibleForPublicIndexing = true // This makes it able to be searched for.
        chill.becomeCurrent() // This makes it current.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displaySearchResult:", name: "DisplaySearchResult1.3", object: nil) // This is used for the App Delegate.
        
        showSpotlight() // This calls the function.
        
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 75, 0)
        
        self.musicScroller.contentInset = UIEdgeInsetsMake(0, 0, 0, 2155)
        
        self.showScroller.contentInset = UIEdgeInsetsMake(0, 0, 0, 1625)
        
    }
    
    var searchMathIndex : Int!
    
    func displaySearchResult(notification : NSNotification) { // This helps display Spotlight.
        
        searchMathIndex = (notification.object as! NSString).integerValue
        
    }
    
    var uniqueIndentifier = 1.3
    
    func showSpotlight() { // This makes it display in spotlight.
        
        let searchSchool = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchSchool.title = "Chill" // This will be the title displayed.
        searchSchool.keywords = ["Chll", "About Amit"] // These keywords are there to get there.
        searchSchool.contentDescription = "This is about Amit's chill zone." // This is the description that will be displayed.
        
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: "\(uniqueIndentifier)", domainIdentifier: "com.amitnkalra.Chill", attributeSet: searchSchool) // For App Delegate
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchableItem]) { // Error
            
            (error : NSError?) -> Void in
            
            if error != nil {
                
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
                playReadOver()
        
        //Animated Picture
        
        AnimatedPicture.layer.masksToBounds = true
        AnimatedPicture.image = images[index++]
        animateAnimatedPicture()
        
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
    
    @IBAction func song15(sender: AnyObject) {
        
        if let peace = NSURL(string: "https://itun.es/us/OJ69-?i=1056418404") {
            
            UIApplication.sharedApplication().openURL(peace)
        }
        
    }
    
    @IBAction func song14(sender: AnyObject) {
        
        if let panda = NSURL(string: "https://itun.es/us/dbv4ab?i=1088507977") {
            
            UIApplication.sharedApplication().openURL(panda)
        }
        
    }
    
    @IBAction func song13(sender: AnyObject) {
        
        if let low = NSURL(string: "https://itun.es/us/ZmCCab?i=1081197914") {
            
            UIApplication.sharedApplication().openURL(low)
        }
        
    }
    
    @IBAction func song12(sender: AnyObject) {
        
        if let good = NSURL(string: "https://itun.es/us/QoIs5?i=961160110") {
            
            UIApplication.sharedApplication().openURL(good)
        }
        
    }
    
    @IBAction func song11(sender: AnyObject) {
        
        if let tlop = NSURL(string: "https://itun.es/us/L4MHbb") {
            
            UIApplication.sharedApplication().openURL(tlop)
        }
        
    }
    
    @IBAction func song10(sender: AnyObject) {
        
        if let tooYoung = NSURL(string: "https://soundcloud.com/postmalone/too-young") {
            
            UIApplication.sharedApplication().openURL(tooYoung)
        }
        
    }
    
    @IBAction func song9(sender: AnyObject) {
        
        if let love = NSURL(string: "https://itun.es/us/0ulS4?i=951104823") {
            
            UIApplication.sharedApplication().openURL(love)
        }
        
    }
    
    @IBAction func song8(sender: AnyObject) {
        
        if let jCole = NSURL(string: "https://itunes.apple.com/us/album/no-role-modelz/id940845223?i=940845268") {
            
            UIApplication.sharedApplication().openURL(jCole)
        }
        
    }
    
    @IBAction func song7(sender: AnyObject) {
        
        if let postMalone = NSURL(string: "https://itunes.apple.com/us/album/white-iverson/id1028466085?i=1028466088") {
            
            UIApplication.sharedApplication().openURL(postMalone)
        }
    }
    
    @IBAction func song6(sender: AnyObject) {
        
        if let taylorSwift = NSURL(string: "https://itunes.apple.com/us/album/style/id907242701?i=907242704") {
            
            UIApplication.sharedApplication().openURL(taylorSwift)
        }
        
    }
    
    @IBAction func song5(sender: AnyObject) {
        
        if let draftPunk = NSURL(string: "https://itunes.apple.com/us/album/get-lucky-feat.-pharrell-williams/id617154241?i=617154366") {
            
            UIApplication.sharedApplication().openURL(draftPunk)
        }
        
    }
    
    @IBAction func song4(sender: AnyObject) {
        
        if let bastile = NSURL(string: "https://itunes.apple.com/us/album/pompeii/id672945248?i=672945258") {
            
            UIApplication.sharedApplication().openURL(bastile)
        }
    }
    
    @IBAction func song3(sender: AnyObject) {
        
        if let theWeeknd = NSURL(string: "https://itunes.apple.com/us/album/the-hills/id1017804831?i=1017805136") {
            
            UIApplication.sharedApplication().openURL(theWeeknd)
        }
        
    }
    
    @IBAction func song2(sender: AnyObject) {
        
        if let drake = NSURL(string: "https://itunes.apple.com/us/album/back-to-back/id1025129692?i=1025129697") {
            
            UIApplication.sharedApplication().openURL(drake)
        }
    }
    
    @IBAction func song1(sender: AnyObject) {
        
        if let pharrel = NSURL(string: "https://itunes.apple.com/us/album/happy-from-despicable-me-2/id823593445?i=823593456") {
            
            UIApplication.sharedApplication().openURL(pharrel)
        }
    }
    
    @IBAction func show10(sender: AnyObject) {
        
        if let DJ = NSURL(string: "http://www.nick.com/drake-and-josh/") {
            
            UIApplication.sharedApplication().openURL(DJ)
        }
        
    }
    
    @IBAction func show9(sender: AnyObject) {
        
        if let JR = NSURL(string: "https://www.youtube.com/user/JusReign") {
            
            UIApplication.sharedApplication().openURL(JR)
        }
        
    }
    
    @IBAction func show8(sender: AnyObject) {
        
        if let fousey = NSURL(string: "https://www.youtube.com/user/fouseytube") {
            
            UIApplication.sharedApplication().openURL(fousey)
        }
        
    }
    
    @IBAction func show7(sender: AnyObject) {
        
        if let MKBHD = NSURL(string: "https://www.youtube.com/user/marquesbrownlee") {
            
            UIApplication.sharedApplication().openURL(MKBHD)
        }
    }
    
    @IBAction func show6(sender: AnyObject) {
        
        if let TLD = NSURL(string: "https://www.youtube.com/user/tldtoday") {
            
            UIApplication.sharedApplication().openURL(TLD)
        }
        
    }
    
    @IBAction func show5(sender: AnyObject) {
        
        if let CN = NSURL(string: "https://www.youtube.com/user/caseyneistat") {
            
            UIApplication.sharedApplication().openURL(CN)
        }
        
    }
    
    @IBAction func show4(sender: AnyObject) {
        
        if let RGS = NSURL(string: "http://www.toonova.com/regular-show") {
            
            UIApplication.sharedApplication().openURL(RGS)
        }
    }
    
    @IBAction func show3(sender: AnyObject) {
        
        if let LR = NSURL(string: "http://disneyxd.disney.com/lab-rats") {
            
            UIApplication.sharedApplication().openURL(LR)
        }
        
    }
    
    @IBAction func show2(sender: AnyObject) {
        
        if let SB = NSURL(string: "http://www.nick.com/spongebob-squarepants/episodes/") {
            
            UIApplication.sharedApplication().openURL(SB)
        }
    }
    
    @IBAction func show1(sender: AnyObject) {
        
        if let SV = NSURL(string: "http://www.hbo.com/silicon-valley") {
            
            UIApplication.sharedApplication().openURL(SV)
        }
    }
    
}