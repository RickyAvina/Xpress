//
//  CheckFirstTime.swift
//  Xpress
//
//  Created by Maricela Avina on 7/19/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import Foundation

class GlobalData {
    
    static let sharedInstance = GlobalData()
    
    static var items = [[String:String]]()   // array of dictionaries
    static var itemInfo = [String:Any]()  // contains all info of each item
        
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