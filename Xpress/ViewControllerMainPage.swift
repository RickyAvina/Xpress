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
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var accountLabel: UILabel!
    @IBOutlet var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (GlobalData.isFirstLaunch){
            loginButton.hidden = true
            accountLabel.hidden = true
            registerButton.hidden = true
        } else {
            loginButton.hidden = false
            accountLabel.hidden = false
            registerButton.hidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
}
