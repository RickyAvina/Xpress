//
//  ViewControllerReceipt.swift
//  Xpress
//
//  Created by Maricela Avina on 7/31/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerReceiptPage : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var transactionIdentifierLabel: UILabel!
    @IBOutlet var purchaseLabel: UILabel!
    
    @IBOutlet var items: UITableView!
    
    override func viewDidLoad() {
        transactionIdentifierLabel.text = "Transaction Identifier\n\(ViewControllerListPage.transacIdentifier)"
        super.viewDidLoad()
    
        items.delegate = self
        items.dataSource = self
        
        items.registerNib(UINib(nibName: "Item", bundle: nil), forCellReuseIdentifier: "itemID")
        
        var total : Double = 0
        
        for i in 0..<GlobalData.items.count{
            print("price: \(GlobalData.items[i]["price"] as! Double)")
            total += GlobalData.items[i]["price"] as! Double
            print("total: \(total)")
            
        }
        
        var totalText = "\(total)"
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        //let numberFromField = (NSString(string: totalText).doubleValue)
        totalText = formatter.stringFromNumber(total)!
        
        purchaseLabel.text = "Purchase Successful for \(totalText)"
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int = 0
        
        if (GlobalData.items.count != 0 && tableView.isEqual(items)){
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
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let HeightOfCellCreatedInXIBFILE : CGFloat = 200
        
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

    
    override func didReceiveMemoryWarning() {
        
    }
}