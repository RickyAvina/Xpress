//
//  CheckoutViewController.swift
//  Xpress
//
//  Created by Maricela Avina on 7/21/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import UIKit
import Stripe

class CheckoutViewController: UIViewController, STPPaymentContextDelegate{
    
    let stripePublishableKey = "pk_test_XvvvpT9CbWsx3MOlHeOsTZPL"
    let backendBaseURL : String? = "https://xpressinstore.herokuapp.com"
    let customerID: String? = "cus_8rdgBT9sgcE34Y"
    let appleMerchantID : String? = nil
}
