//
//  ViewController.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/18/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    @IBOutlet weak var aboutMe: UIButton!
    
    @IBOutlet weak var projects: UIButton!
    
    @IBOutlet weak var foam: UIImageView!
    
    @IBOutlet weak var sky: UIImageView!
    
    @IBOutlet weak var pink: UIImageView!
    
    @IBOutlet weak var yellow: UIImageView!
    
    @IBOutlet weak var dubdub: UIButton!
    
    @IBOutlet weak var experience: UIButton!
    
    @IBOutlet weak var instagramIcon: UIImageView!
    
    @IBOutlet weak var snapchatIcon: UIImageView!
    
    @IBOutlet weak var socialScroller: UIScrollView!
    
    @IBOutlet weak var tweetbotIcon: UIImageView!
    
    @IBOutlet weak var faceBookIcon: UIImageView!
    
    @IBOutlet weak var menuBackgroundImage: UIImageView!
    
    @IBOutlet weak var menuPicture: UIImageView!
    
    let images = [
        
        UIImage(named: "TheRealMe.jpg")!,
        
        UIImage(named: "appleAmit.jpg")!]
    
    
    var index = 0
    let animationDuration: NSTimeInterval = 0.25
    let switchingInterval: NSTimeInterval = 2
    
    // Snapchat add me! snapchat.com/add/amitnkalra
    
    let addMeSnap = [
        
        UIImage(named: "Snapchat1.png")!,
        
        UIImage(named: "Snapchat2.png")!,
        
        UIImage(named: "Snapchat3.png")!,
        
        UIImage(named: "Snapchat4.png")!,
        
        UIImage(named: "Snapchat2.png")!]
    
    var snapIndex = 0
    let snapAnimationDuration: NSTimeInterval = 0.25
    let snapSwitchingInterval: NSTimeInterval = 0.25
    
    private var audioPlayer: AVAudioPlayer? {
        didSet {
            
        }
    }
    
    private func playWelcome() {
        // Set up the audio session
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            fatalError("Unable to set the audio session because: \(error)")
        }
        
        guard
            let audioURL = NSBundle.mainBundle().URLForResource("Hey", withExtension: "mp3"),
            let player = try? AVAudioPlayer(contentsOfURL: audioURL)
            
            else { fatalError("Unable to create player") }
        self.audioPlayer = player
        player.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.socialScroller.contentInset = UIEdgeInsetsMake(0, 0, 0, 5)
        
        menuPicture.layer.cornerRadius = 100
        menuPicture.clipsToBounds = true
        menuPicture.layer.masksToBounds = true
        menuPicture.layer.borderColor = UIColor.blueColor().CGColor
        
        menuPicture.layer.masksToBounds = true
        menuPicture.image = images[index++] // Yes, I know ++ will be gone in Swift 3 so I HAD TO USE IT BEFORE HE LEFT ME 😪
        animateMenuPicture()
        
        snapchatIcon.layer.masksToBounds = true
        snapchatIcon.image = addMeSnap[snapIndex++] // Yes, I know ++ will be gone in Swift 3 so I HAD TO USE IT BEFORE HE LEFT ME 😪
        animateSnapchat()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.menuPicture.layer.cornerRadius = self.menuPicture.frame.size.width / 2
    }
    
    //Animated Picture
    
    func animateMenuPicture() {
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(self.switchingInterval * NSTimeInterval(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.animateMenuPicture()
            }
        }
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        menuPicture.layer.addAnimation(transition, forKey: kCATransition)
        menuPicture.image = images[index]
        
        CATransaction.commit()
        
        index = index < images.count - 1 ? index + 1 : 0
    }
    
    // Animate Snapchat
    
    func animateSnapchat() {
        
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(snapAnimationDuration)
        CATransaction.setCompletionBlock {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(self.snapSwitchingInterval * NSTimeInterval(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.animateSnapchat()
            }
        }
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        snapchatIcon.layer.addAnimation(transition, forKey: kCATransition)
        snapchatIcon.image = addMeSnap[snapIndex]
        
        CATransaction.commit()
        
        snapIndex = snapIndex < addMeSnap.count - 1 ? snapIndex + 1 : 0
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        audioPlayer?.pause()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let noAlerts = NSUserDefaults.standardUserDefaults() //I like to shorten it a little, it makes my code more readable
        
        if !noAlerts.boolForKey("ripAlert") {
            
                        playWelcome()
            
            let welcomeAlert = UIAlertController(title: "Welcome to my WWDC scholorship app!", message: "I have tried putting everything I've got and everything I've learned while learning Swift. Recommended to use on 5.5' screen.", preferredStyle: UIAlertControllerStyle.Alert)
            welcomeAlert.addAction(UIAlertAction(title: "Let's begin.", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(welcomeAlert, animated: true, completion: nil)
            
            noAlerts.setBool(true, forKey: "ripAlert")
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
            aboutMe.center.x = self.view.frame.width + 90
            foam.center.x = self.view.frame.width + 120
            projects.center.y = self.view.frame.height + 90
            sky.center.y = self.view.frame.height + 120
            experience.center.x = self.view.frame.height + 90
            pink.center.x = self.view.frame.height + 120
            menuPicture.center.y = self.view.frame.height + 90
            dubdub.center.x = self.view.frame.height + 90
            yellow.center.x = self.view.frame.height + 120
            socialScroller.center.y = self.view.frame.height + 90

            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: ({
                self.aboutMe.center.x = self.view.frame.width / 2
            }), completion: nil)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: ({
                self.foam.center.x = self.view.frame.width / 2.6
            }), completion: nil)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: ({
                self.projects.center.y = self.view.frame.height / 1.7
            }), completion: nil)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: ({
                self.sky.center.y = self.view.frame.height / 1.7
            }), completion: nil)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: ({
                self.menuPicture.center.y = self.view.frame.height / 4
            }), completion: nil)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: ({
                self.experience.center.x = self.view.frame.width / 2
            }), completion: nil)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: ({
                self.pink.center.x = self.view.frame.width / 2.6
            }), completion: nil)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: ({
                self.yellow.center.x = self.view.frame.width / 1.6
            }), completion: nil)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: ({
                self.dubdub.center.x = self.view.frame.width / 2
            }), completion: nil)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: ({
                self.socialScroller.center.y = self.view.frame.height / 1.05
            }), completion: nil)
            
        } else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func instagram(sender: AnyObject) {
        
        if let insta = NSURL(string: "http://instagram.com:/amitnkalra") {
            
            UIApplication.sharedApplication().openURL(insta)
        }
    }
    
    @IBAction func snapchat(sender: AnyObject) {
        
        if let snap = NSURL(string: "http://snapchat.com/add/amitnkalra") {
            UIApplication.sharedApplication().openURL(snap)
        }
    }
    
    @IBAction func facebook(sender: AnyObject) {
        
        if let face = NSURL(string: "http://facebook.com/amitnkalra") {
            UIApplication.sharedApplication().openURL(face)
        }
    }
    
    @IBAction func tweetbot(sender: AnyObject) {
        
        if let twitter = NSURL(string: "http://twitter.com/amitnkalra") {
            
            UIApplication.sharedApplication().openURL(twitter)
        }
    }
    
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

