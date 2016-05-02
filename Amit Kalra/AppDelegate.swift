//
//  AppDelegate.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/18/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import UIKit
import CoreSpotlight
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, NSUserActivityDelegate {

    
    // MARK: Properties
    var shortcutItem: UIApplicationShortcutItem?

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Fabric.with([Crashlytics.self])
        
        var performShortcutDelegate = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            
            print("Application launched via shortcut")
            self.shortcutItem = shortcutItem
            
            performShortcutDelegate = false
        }
        
        return performShortcutDelegate
        
        
        return true
    }
    
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void)
    {
        
        print("Application performActionForShortcutItem")
        completionHandler( handleShortcut(shortcutItem) )
        
    }
    
    func handleShortcut( shortcutItem:UIApplicationShortcutItem ) -> Bool {
        print("Handling shortcut")
        
        var succeeded = false
        
        if( shortcutItem.type == "be.thenerd.appshortcut.new-user" ) {
            
            // Add your code here
            print("- Handling \(shortcutItem.type)")
            
            // Get the view controller you want to load
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let addUserVC = mainSB.instantiateViewControllerWithIdentifier("ViewController") as! MenuViewController
            
            let navVC = self.window?.rootViewController as! UINavigationController
            navVC.pushViewController(addUserVC, animated: true)
            
            succeeded = true
            
        }
        
        return succeeded
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        print("Application did become active")
        
        guard let shortcut = shortcutItem else { return }
        
        print("- Shortcut property has been set")
        
        handleShortcut(shortcut)
        
        self.shortcutItem = nil
        
    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        if userActivity.activityType == CSSearchableItemActionType {
            
            
            let identifier = userActivity.userInfo![CSSearchableItemActivityIdentifier]
            
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResult1", object: identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResult1.1", object: identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResult1.2", object: identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults1.3", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults1.4", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults1.5", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResult1.6", object: identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResult1.7", object: identifier)
            
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults2", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults2.1", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults2.2", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults2.3", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults2.4", object : identifier)

            
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults3", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults3.1", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults3.2", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults3.3", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults3.4", object : identifier)
            
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults4.1", object : identifier)
            NSNotificationCenter.defaultCenter().postNotificationName("DisplaySearchResults4.2", object : identifier)

            
            
            
        }
        
        return true
    }

}

