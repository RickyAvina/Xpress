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
    
    static var items = [[String:Any]]()   // array of dictionaries for item info
    static let isFirstLaunch = NSUserDefaults.isFirstLaunch()
    
    var app : BuiltApplication?
    
    func initialize(){
        app = Built.applicationWithAPIKey("blt2543bf0c950e6d5d")
    }
    
    func registerUser(firstName: String, lastName: String, email: String, password: String, onSuccess: ()->()){
        
        let UserClass = app!.classWithUID("user")
        let userQuery = UserClass.query()
        userQuery.whereKeyExists("email")
        
        userQuery.execInBackground{(responseType: ResponseType, result: QueryResult!, error: NSError!) -> Void in
            if (error == nil){
                print("Query executed successfully")
                let emails : [String] = result!.getResult() as![String]
                
                let user = UserClass.object()
                
                for i in 0 ..< emails.count{
                    if (emails[i] == email){
                        print("ACCOUNT WITH EMAIL ALREADY EXISTS")
                        break
                    }
                    
                }
                
                user["firstname"] = firstName
                user["lastname"] = lastName
                user["email"] = email
                user["password"] = password
                
                user.saveInBackgroundWithCompletion{(repsonseType: ResponseType, error: NSError!) -> Void in
                    if error == nil{
                        print("User created successfully!")
                    } else {
                        print(error.userInfo)
                    }
                }
                
            } else {
                print("Error in Query: \(error.userInfo)")
            }
        }
    }
    
        func registerUser(firstName: String, lastName: String, middleInitial: String, email: String, password: String, onSuccess: ()->()){
            
        }
}