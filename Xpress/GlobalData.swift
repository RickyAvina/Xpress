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
    
    static var items = [[String:Any]]()   // array of dictionaries
    static var itemInfo = [String:Any]()  // contains all info of each item
        
    static let isFirstLaunch = NSUserDefaults.isFirstLaunch()
    
   }