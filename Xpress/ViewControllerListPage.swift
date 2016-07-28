//
//  ViewControllerListPage.swift
//  Xpress
//
//  Created by Maricela Avina on 7/20/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import UIKit
import PassKit

class ViewControllerListPage: UIViewController, UITableViewDelegate, UITableViewDataSource, PKPaymentAuthorizationViewControllerDelegate  {
    
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var totalAmountLabel: UILabel!
    
    @IBOutlet var reviewCreditCardInformationLabel: UIButton!
    @IBOutlet var checkoutLabel: UIButton!
    
    let SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex] // supported payment types
    let ApplePayXpressMerchantID = "merchant.com.rickyavina.Xpress"
    
    // gives the user authorization to purchase
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: ((PKPaymentAuthorizationStatus) -> Void)){
        completion(PKPaymentAuthorizationStatus.Success)
        
        // send info to backend to procces
    }
    
    // called when payment completes
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.registerNib(UINib(nibName: "Item", bundle: nil), forCellReuseIdentifier: "itemID")
        
        if (PKPaymentAuthorizationViewController.canMakePayments() == false){
            UIAlertController(title: "Device not compliable with apple pay", message: "Please use a device that supports Apple Pay", preferredStyle: UIAlertControllerStyle.Alert)
            // dont display Apple pay stuff
            checkoutLabel.hidden = true
            reviewCreditCardInformationLabel.hidden = true
        }
        
        var total : Double = 0
        
        for i in 0..<GlobalData.items.count{
            total += GlobalData.items[i]["price"] as! Double
        }
        
        totalAmountLabel.text = "$\(total)"
    }
    
    @IBAction func addCreditCard(sender: UIButton) {
        
    }
    
    
    @IBAction func checkout(sender: UIButton) {
        
        if (PKPaymentAuthorizationViewController.canMakePaymentsUsingNetworks(SupportedPaymentNetworks) == false){
            // credit card not added
        } else {
            let request = PKPaymentRequest()
            request.merchantIdentifier = ApplePayXpressMerchantID
            request.supportedNetworks = SupportedPaymentNetworks
            request.merchantCapabilities = PKMerchantCapability.Capability3DS
            request.countryCode = "US"
            request.currencyCode = "USD"
            
            request.paymentSummaryItems = [
                PKPaymentSummaryItem(label: "Absolutely Nothing", amount: 0.01)
            ]
            
            let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
            applePayController.delegate = self
            
            self.presentViewController(applePayController, animated: true, completion: nil)
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int = 0
        
        if (GlobalData.items.count != 0 && tableView.isEqual(listTableView)){
            count = GlobalData.items.count
        }
        
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("itemID", forIndexPath: indexPath) as UITableViewCell! as! Item!
        
        if (cell == nil){
            cell = Item(style: UITableViewCellStyle.Default, reuseIdentifier: "itemID")
        }
        
        if (GlobalData.items.count != 0){
            if (GlobalData.items[indexPath.row]["name"] != nil){
                cell?.name.text = GlobalData.items[indexPath.row]["name"] as? String
            }
            if (GlobalData.items[indexPath.row]["price"] != nil){
                cell?.price.text = "$0.75"
            }
            if (GlobalData.items[indexPath.row]["upcCode"] != nil){
                cell?.upcCode.text = GlobalData.items[indexPath.row]["upcCode"] as? String
            }
            if (GlobalData.items[indexPath.row]["desc"] != nil){
                cell?.upcCode.text = GlobalData.items[indexPath.row]["desc"] as? String
            }
        }
    
            return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let HeightOfCellCreatedInXIBFILE : CGFloat = 400
        
        return HeightOfCellCreatedInXIBFILE
    }
}
