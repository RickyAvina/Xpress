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
    
    @IBOutlet var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (GlobalData.isFirstLaunch || (GlobalData.sharedInstance.app?.user().isAuthenticated())! == true){
        }
        
        if (GlobalData.sharedInstance.app?.user().email != nil){
            emailLabel.text = GlobalData.sharedInstance.app?.user().email
        } else {
            emailLabel.text = "Guest"
        }
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
}
