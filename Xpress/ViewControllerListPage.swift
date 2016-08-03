//
//  ViewControllerListPage.swift
//  Xpress
//
//  Created by Maricela Avina on 7/20/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import UIKit
import PassKit

class ViewControllerListPage: UIViewController, UITableViewDelegate, UITableViewDataSource, PKPaymentAuthorizationViewControllerDelegate, UIPopoverPresentationControllerDelegate  {
    
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var totalAmountLabel: UILabel!
    
    @IBOutlet var checkoutLabel: UIButton!
    var totalPrice : Double?
    
    var lib: PKPassLibrary?
    static var checkOutReady : Bool = false
    
    var paymentToken : PKPaymentToken!
    static var transacIdentifier : String!
    
    let SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex] // supported payment types
    let ApplePayXpressMerchantID = "merchant.com.rickyavina.Xpress"
    
    // gives the user authorization to purchase
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: ((PKPaymentAuthorizationStatus) -> Void)){
        completion(PKPaymentAuthorizationStatus.Success)
        
        paymentToken = payment.token
        // send info to backend to procces
        ViewControllerListPage.transacIdentifier = paymentToken.transactionIdentifier
    }
    
    // called when payment completes
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("receipt")
        self.presentViewController(vc, animated: true, completion: {
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        lib = PKPassLibrary()
        
        listTableView.registerNib(UINib(nibName: "Item", bundle: nil), forCellReuseIdentifier: "itemID")
        
        if (PKPaymentAuthorizationViewController.canMakePayments() == false){
            let myAlert = UIAlertView()
            myAlert.title = "Apple pay not supported!"
            myAlert.message = "Please update or use a device that supports Apple Pay"
            myAlert.addButtonWithTitle("Ok")
            myAlert.delegate = self
            myAlert.show()
            // dont display Apple pay stuff
            checkoutLabel.hidden = true
            
        }
        
        var total : Double = 0
        
        for i in 0..<GlobalData.items.count{
            print("price: \(GlobalData.items[i]["price"] as! Double)")
            total += GlobalData.items[i]["price"] as! Double
            print("total: \(total)")

        }
        
        totalPrice = total
        var totalText = "\(total)"
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        //let numberFromField = (NSString(string: totalText).doubleValue)
        totalText = formatter.stringFromNumber(total)!
        
        totalAmountLabel.text = totalText
    }
    
    @IBAction func addCreditCard(sender: UIButton) {
        lib!.openPaymentSetup()
    }
    
    
    @IBAction func checkout(sender: UIButton) {
        
        if (totalPrice>0){
            if (ViewControllerListPage.checkOutReady == true || GlobalData.sharedInstance.app?.currentUser.email != "guest@guest.com"){
                if (PKPassLibrary.isPassLibraryAvailable()){
                if (PKPaymentAuthorizationViewController.canMakePaymentsUsingNetworks(SupportedPaymentNetworks) == false){
                    // credit card not added
                    let alert = UIAlertController(title: "No payment information!", message:"Please enter a valid credit card", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                        self.presentViewController(alert, animated: true){
                            self.lib!.openPaymentSetup()
                        }
                        })
                    
                   // print("Payment not authorized")
                } else {
                    let request = PKPaymentRequest()
                    request.merchantIdentifier = ApplePayXpressMerchantID
                    request.supportedNetworks = SupportedPaymentNetworks
                    request.merchantCapabilities = PKMerchantCapability.Capability3DS
                    request.countryCode = "US"
                    request.currencyCode = "USD"
                    
                    
                    let behavior = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundPlain,
                                                          scale: 2,
                                                          raiseOnExactness: false,
                                                          raiseOnOverflow: false,
                                                          raiseOnUnderflow: false,
                                                          raiseOnDivideByZero: false)
                    
                    let calcDN : NSDecimalNumber = NSDecimalNumber(double: totalPrice!)
                        .decimalNumberByRoundingAccordingToBehavior(behavior)
                   
                    request.paymentSummaryItems = [
                        PKPaymentSummaryItem(label: "Xpress Shopping Cart", amount: 0.01)
                    ]
                    
                    let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
                    applePayController.delegate = self
                    
                    self.presentViewController(applePayController, animated: true, completion: nil)

                }
                }
            } else {
                self.performSegueWithIdentifier("presentPopover", sender: nil)
            }
        } else {
            let myAlert = UIAlertView()
            myAlert.title = "Nothing in Cart!"
            myAlert.message = "You must scan an item before purchasing!"
            myAlert.addButtonWithTitle("Ok")
            myAlert.delegate = self
            myAlert.show()
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "presentPopover"{
            if (totalPrice>0){
                return true
            } else {
                return false
            }
        }
        
        if (identifier == "listToMain"){
            return true
        }
        return false
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
                cell?.price.text = "$\(String((GlobalData.items[indexPath.row]["price"])!))"
            }
            if (GlobalData.items[indexPath.row]["upcCode"] != nil){
                cell?.upcCode.text = GlobalData.items[indexPath.row]["upcCode"] as? String
            }
            
            if (GlobalData.items[indexPath.row]["itemImage"] != nil){
                cell?.itemImage.image = GlobalData.items[indexPath.row]["itemImage"] as? UIImage
            }
            
        }
    
            return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("itemDescription")
        
        ViewControllerDetailPage.name = GlobalData.items[indexPath.row]["name"] as? String
        
        ViewControllerDetailPage.desc = GlobalData.items[indexPath.row]["desc"] as? String
        
        self.presentViewController(vc, animated: true, completion:{
            
        })
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let HeightOfCellCreatedInXIBFILE : CGFloat = 500
        
        return HeightOfCellCreatedInXIBFILE
    }
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            GlobalData.items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
