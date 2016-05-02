//
//  Boot.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/19/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit
import AVFoundation

class Boot: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let booting = UIImage(named: "LoadBoot.JPG")
        logo.image = booting
        // Show the home screen after a bit. Calls the show() function.
        let timer = NSTimer.scheduledTimerWithTimeInterval(
            3.5, target: self, selector: Selector("show"), userInfo: nil, repeats: false)
    }
    func show() {
        self.performSegueWithIdentifier("showWelcome", sender: self)
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
            let audioURL = NSBundle.mainBundle().URLForResource("BootingSound", withExtension: "wav"),
            let player = try? AVAudioPlayer(contentsOfURL: audioURL)
            
            else { fatalError("Unable to create player") }
        self.audioPlayer = player
        player.play()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        playWelcome()
    }
}