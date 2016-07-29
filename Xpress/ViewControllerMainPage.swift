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
    
    @IBOutlet var accountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "clouds.jpeg")!)
        
        if (GlobalData.isFirstLaunch || (GlobalData.sharedInstance.app?.user().isAuthenticated()) == true){
            
        }
        
        if (GlobalData.sharedInstance.app?.currentUser.isAuthenticated() == true){
            accountButton.setTitle("Logged in as: \((GlobalData.sharedInstance.app?.currentUser.email)!)", forState: .Normal)
        } else {
            accountButton.setTitle("Logged in as: Guest", forState: .Normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
}
