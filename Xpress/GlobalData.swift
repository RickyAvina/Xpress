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
    var builtUser : BuiltUser?
    var builtApplication : BuiltApplication?
    
    func initialize(){
        let builtApplicationAPIKey = "blt2543bf0c950e6d5d"
        app = Built.applicationWithAPIKey(builtApplicationAPIKey)
     //   builtUser = app?.user()
        
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
        
        if let theApp = app {
            let userObject : BuiltUser = theApp.user()
            userObject.email = email
            userObject.password = password
            userObject.confirmPassword = password
            userObject.firstName = firstName
            userObject.lastName = lastName
            
            userObject.registerUserInBackgroundWithCompletion({ (res, error) -> Void in
                
                if (error == nil){
                    print("Registed")
                    onSuccess()
                } else {
                    print("Registration Failed")
                    print(error)
                }
            })
        }
    }
    
    func registerUser(firstName: String, lastName: String, middleInitial: String, email: String, password: String, onSuccess: ()->()){
        if let theApp = app {
            let userObject : BuiltUser = theApp.user()
            userObject.email = email
            userObject.password = password
            userObject.confirmPassword = password
            userObject.firstName = "\(firstName), \(middleInitial)"
            userObject.lastName = lastName
            
            userObject.registerUserInBackgroundWithCompletion({ (res, error) -> Void in
                
                if (error == nil){
                    print("Registed")
                    onSuccess()
                } else {
                    print("Registration Failed")
                    print(error)
                }
            })
        }
    }
    
    
    func loginUser(email: String, password : String, onSuccess: ()->()){
        if let theApp = app {
            let userObject:BuiltUser = theApp.user()
            userObject.loginInBackgroundWithEmail(email, andPassword: password) {
                (responseType: ResponseType, error: NSError!) -> Void in
                
                if (error == nil){
                    userObject.setAsCurrentUser()
                    /* print("User: \(GlobalData.sharedInstance.app?.currentUser)")
                     print("Authtoken: \(userObject.authtoken)")
                     print("IsAuthenticated: \(GlobalData.sharedInstance.app?.currentUser.isAuthenticated())")*/
                    print("^(%%%%")
                    print(GlobalData.sharedInstance.app?.currentUser.email)
                    onSuccess()
                } else {
                    print("Error logging in: \(error)")
                }
            }
        }
    }
    
    func logoutCurrentUser(onSuccess: ()->()){
        GlobalData.sharedInstance.app?.currentUser.logoutInBackgroundWithCompletion{ (responseType: ResponseType, error: NSError!) -> Void in
            if (error == nil) {
                // user logged out successfully
                 print("Did logout")
                self.loginUser("guest@guest.com", password: "guest", onSuccess: {
                   
                })
            } else {
                // login failed
                print("ERR: \(error.userInfo))")
            }
        }
    }

    
}
