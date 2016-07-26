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
    
    var emailIsInUse : Bool?
    var app : BuiltApplication?
    
    func initialize(){
        app = Built.applicationWithAPIKey("blt2543bf0c950e6d5d")
    }
    
    func verifyUser(email email:String) -> Bool{
        
        var myBool : Bool?
        
        let UserClass = app!.classWithUID("user")
        let userQuery = UserClass.query()
        userQuery.whereKeyExists("email")
        
        userQuery.execInBackground{(responseType: ResponseType, result: QueryResult!, error: NSError!) -> Void in
            if (error == nil){
                for i in 0 ..< result.getResult().count{
                    let r = result.getResult()[i]
                    let storedEmail = r["email"] as! String
                    if (email == storedEmail){
                        print("EMAIL ALEREADY IN USE")
                        myBool = false
                        break
                    } else {
                        myBool = true
                        print("Email not used")
                    }
                }
            }
        }
        
            if (myBool == false){
                return false
            } else {
                return true
            }
    
    }
    
    func registerUser(firstName: String, lastName: String, email: String, password: String, onSuccess: ()->()){
        
        var emailInUse : Bool?
        
        let UserClass = app!.classWithUID("user")
        let userQuery = UserClass.query()
        
        userQuery.execInBackground{(responseType: ResponseType, result: QueryResult!, error: NSError!) -> Void in
            if (error == nil){
                print("Query executed successfully")
                
                //  let r = (result.getResult()[0])
                //  let emails = r["email"]! as! String
                
                //   print("*******:\(emails)")
                
                for i in 0 ..< result.getResult().count{
                    let r = result.getResult()[i]
                    let storedEmail = r["email"] as! String
                    if (email == storedEmail){
                        emailInUse = true
                        print("EMAIL ALEREADY IN USE")
                        self.emailIsInUse = true
                        break
                    } else {
                        emailInUse = false
                        self.emailIsInUse = false
                        print("Email not used")
                    }
                }
                
                if (emailInUse == false){
                    
                    
                    let user = UserClass.object()
                    
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
                    } // end saveInback
                    
                } else {
                    // print("Error in Query: \(error.userInfo)")
                } // end else
            }  // end userQuery
            
        } 
        
    } // end func
    
    func registerUser(firstName: String, lastName: String, middleInitial: String, email: String, password: String, onSuccess: ()->()){
        let UserClass = app!.classWithUID("user")
        let userQuery = UserClass.query()
        userQuery.whereKeyExists("email")
        
        userQuery.execInBackground{(responseType: ResponseType, result: QueryResult!, error: NSError!) -> Void in
            if (error == nil){
                print("Query executed successfully")
                //  let emails : [String] = result!.getResult() as![String]
                
                let user = UserClass.object()
                
                //  for i in 0 ..< emails.count{
                //    if (emails[i] == email){
                //     print("ACCOUNT WITH EMAIL ALREADY EXISTS")
                //     break
                //   }
                
                // }
                
                user["firstname"] = firstName
                user["middleinitial"] = middleInitial
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
    
    func loginVerified(email email: String, password: String)->Bool{
        let UserClass = app!.classWithUID("user")
        let userEmailQuery = UserClass.query()
        userEmailQuery.whereKeyExists("email")
        
        var myBool : Bool?
        
        userEmailQuery.execInBackground{(responseType: ResponseType, result: QueryResult!, error: NSError!) -> Void in
            
            
            for i in 0 ..< result.getResult().count{
                let r = result.getResult()[i]
                let storedEmail = r["email"] as! String
                
                if (email == storedEmail){
                    let passwordQuery = UserClass.query()
                    passwordQuery.whereKeyExists("password")
                    
                    passwordQuery.execInBackground{(responseType: ResponseType, result: QueryResult!, error: NSError!) -> Void in
                        let storedPassword = r["password"] as! String
                        
                        if (password == storedPassword){
                            // success
                            myBool = true
                        } else {
                            myBool = false
                        }
                    }
                } else {
                    myBool = false
                }
            }
        }
        
        if (myBool == true){
            return true
        } else {
            return false
        }
    }
}
