//
//  ViewControllerAccountPage.swift
//  Xpress
//
//  Created by Maricela Avina on 7/29/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import Foundation

class ViewControllerAccountPage : UIViewController {
    
    @IBOutlet var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text = "Hello \((GlobalData.sharedInstance.app?.currentUser.firstName)!)!"
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    @IBAction func logout(sender: UIButton) {
        GlobalData.sharedInstance.logoutCurrentUser({
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("login")
            
            self.presentViewController(vc, animated: true, completion: nil)
        })
    }
    
}