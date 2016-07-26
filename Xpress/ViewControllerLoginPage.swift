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
        if (GlobalData.sharedInstance.loginVerified(email: emailTextField.text!, password: passwordTextField.text!) == true){
            print("LOGIN SUCCEEDED")
        } else {
            print ("LOGIN FAILED")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // called when the user click on the view
        self.view.endEditing(true)
    }
    
}
