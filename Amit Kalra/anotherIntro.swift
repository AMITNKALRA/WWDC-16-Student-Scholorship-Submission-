//
//  anotherIntro.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/19/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit
import AVFoundation

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var welcome: UILabel!
    
    func changeWelcome() {
        
        if welcome.text == "Hello." {
            
            welcome.text = "آلو"
            
        } else if welcome.text == "آلو" {
            
            welcome.text = "ալլո"
            
        } else if welcome.text == "ալլո" {
            
            welcome.text = "নমস্কাৰ"
            
        }  else if welcome.text == "নমস্কাৰ" {
            
            welcome.text = "হ্যালো"
            
        }  else if welcome.text == "হ্যালো" {
            
            welcome.text = "ဟဲလို"
            
        }  else if welcome.text == "ဟဲလို" {
            
            welcome.text = "喂"
            
        }  else if welcome.text == "喂" {
            
            welcome.text = "Hallo"
            
        }  else if welcome.text == "Hallo" {
            
            welcome.text = "નમસ્તે"
            
        }  else if welcome.text == "નમસ્તે" {
            
            welcome.text = "Aloha"
            
        }  else if welcome.text == "Aloha" {
            
            welcome.text = "नमस्ते"
            
        }  else if welcome.text == "नमस्ते" {
            
            welcome.text = "今日は"
            
        }  else if welcome.text == "今日は" {
            
            welcome.text = "안녕하십니까"
            
        }  else if welcome.text == "안녕하십니까" {
            
            welcome.text = "ਸਤਿ ਸ੍ਰੀ ਅਕਾਲ।"
            
        }  else if welcome.text == "ਸਤਿ ਸ੍ਰੀ ਅਕਾਲ।" {
            
            welcome.text = "ست سِری اَکال"
            
        }  else if welcome.text == "ست سِری اَکال" {
            
            welcome.text = "Алло"
            
        }  else if welcome.text == "Алло" {
            
            welcome.text = "¡Hola!"
            
        }  else if welcome.text == "¡Hola!" {
            
            welcome.text = "Musta"
            
        }  else if welcome.text == "Musta" {
            
            welcome.text = "Hello."
            
        }
    }
    
    //Swipe Back Gesture
    
    @IBAction func SWIPE(sender: AnyObject) {
        
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
        
    }
    
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
            let audioURL = NSBundle.mainBundle().URLForResource("HelloDub", withExtension: "mp3"),
            let player = try? AVAudioPlayer(contentsOfURL: audioURL)
            
            else { fatalError("Unable to create player") }
        self.audioPlayer = player
        player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "changeWelcome", userInfo: nil, repeats: true)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        playWelcome()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}