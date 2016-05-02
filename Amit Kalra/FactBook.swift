//
//  FactBook.swift
//  Amit Kalra
//
//  Created by Amit Kalra on 4/26/16.
//  Copyright © 2016 Amit Nivedan Kalra. All rights reserved.
//

import Foundation
import UIKit

struct FactBook {
    
    let factsArray = [
        "I like to make films.",
        "I'm going to start daily vlogging this summer!",
        "My favorite color is Midnight Blue mixed with Oceana",
        "I used to be able to do BMX tricks.",
        "I can ride the ribstick very well.",
        "I take Chinese in school.",
        "I ❤️ to run.",
        "I ❤️ CHEESE",
        "I like to wear bright colors.",
        "I am trying to grow a manbun.",
        "I have over 10K+ users on my app!",
        "I ❤️ nature.",
        "I ❤️ hiking.",
        "I ❤️ hot weather.",
        "I like to have the latest Apple Products"
        
    ]
    
    func genRandomFact() -> String {
        
        let arrayCount = UInt32(factsArray.count)
        let randomNumber = arc4random_uniform(arrayCount)
        let finalResult = Int(randomNumber)
        
        //        var randomNumber = Int(arc4random_uniform(UInt32(factsArray.count))) // How it looks when it's all combined. but i dont like this version
        
        return factsArray[finalResult]
    }
}