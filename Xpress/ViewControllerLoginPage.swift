//
//  ViewControllerLoginPage.swift
//  Xpress
//
//  Created by Maricela Avina on 7/19/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import UIKit

class ViewControllerLoginPage: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBAction func login(sender: UIButton) {
        
    GlobalData.sharedInstance.loginUser(emailTextField.text!, password: passwordTextField.text!, onSuccess: {[weak self] in
           // print("IsAuthenticated login screen: \((GlobalData.sharedInstance.app?.currentUser.isAuthenticated()))")
          })
    }
    
   /* override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        
       
        if ((GlobalData.sharedInstance.app?.user().isAuthenticated())! == true){
            if (identifier == "loginToMain"){
                return true
            }
        }
        
        if (identifier == "backToMain"){
            return true
        }
        
        return false
           // return (GlobalData.sharedInstance.app?.user().isAuthenticated())!
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "market.jpeg")!)
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // called when the user click on the view
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
