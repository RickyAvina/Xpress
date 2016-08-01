//
//  ViewControllerMainPage.swift
//  Xpress
//
//  Created by Maricela Avina on 7/18/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import UIKit
import Foundation

class ViewControllerMainPage: UIViewController{
    
    static var isReady : Bool = false
    
    @IBOutlet var accountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print("is auth: \(GlobalData.sharedInstance.app?.currentUser.isAuthenticated())")
        
     //   print("Current user: \(GlobalData.sharedInstance.app?.currentUser.email!)")
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "clouds.jpeg")!)
        
        //if (GlobalData.isFirstLaunch || (GlobalData.sharedInstance.app?.currentUser.isAuthenticated()) == true){
            
       // print("&&&:\(GlobalData.sharedInstance.app?.currentUser)"
    
    }
    
    override func viewDidAppear(animated: Bool) {
       // if (ViewControllerMainPage.isReady == true){
            if (GlobalData.sharedInstance.app?.currentUser.isAuthenticated() == true){
                if (GlobalData.sharedInstance.app?.currentUser.email! == "guest@guest.com"){
                    accountButton.setTitle("Logged in as: Guest", forState: .Normal)
                } else {
                    accountButton.setTitle("Logged in as: \((GlobalData.sharedInstance.app?.currentUser.email)!)", forState: .Normal)
                }
            } else {
                accountButton.setTitle("Logged in as: Guest", forState: .Normal)
            }
        //} else {
       //     accountButton.setTitle("Logged in as: ", forState: .Normal)
       // }
        
    }
    override func didReceiveMemoryWarning() {
        
    }
    
}
