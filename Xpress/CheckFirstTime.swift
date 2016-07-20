//
//  CheckFirstTime.swift
//  Xpress
//
//  Created by Maricela Avina on 7/19/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import Foundation

class CheckFirstTime {
    
    static let sharedInstance = CheckFirstTime()
    
    static var isFirstTime = Bool()
    
    static func firstTimeLaunching()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let isAppAlreadyLaunchedOnce = defaults.stringForKey("isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.setBool(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}