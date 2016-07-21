//
//  ViewControllerListPage.swift
//  Xpress
//
//  Created by Maricela Avina on 7/20/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import UIKit

class ViewControllerListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.registerNib(UINib(nibName: "Item", bundle: nil), forCellReuseIdentifier: "itemID")
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
                cell?.price.text = GlobalData.items[indexPath.row]["price"] as? String
            }
            if (GlobalData.items[indexPath.row]["upcCode"] != nil){
                cell?.upcCode.text = GlobalData.items[indexPath.row]["upcCode"] as? String
            }
            if (GlobalData.items[indexPath.row]["desc"] != nil){
                cell?.upcCode.text = GlobalData.items[indexPath.row]["desc"] as? String
            }
            
            if (GlobalData.items[indexPath.row]["itemImage"] != nil){
                cell.imageView?.image = GlobalData.items[indexPath.row]["itemImage"] as? UIImage
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
