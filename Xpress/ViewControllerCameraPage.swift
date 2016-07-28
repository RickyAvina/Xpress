//
//  ViewControllerCameraPage.swift
//  Xpress
//
//  Created by Maricela Avina on 7/19/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerCameraPage: ViewController, SBSScanDelegate, SBSOverlayControllerDidCancelDelegate {
    
    var picker : SBSBarcodePicker?
    
    @IBOutlet var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = SBSScanSettings.pre47DefaultSettings();
        settings.cameraFacingPreference = SBSCameraFacingDirection.Back
        
        // types of symbologies (types of barcodes)
        settings.setSymbology(SBSSymbology.EAN13, enabled: true)
        settings.setSymbology(SBSSymbology.EAN8, enabled: true)
        settings.setSymbology(SBSSymbology.Aztec, enabled: true)
        settings.setSymbology(SBSSymbology.Code11, enabled: true)
        settings.setSymbology(SBSSymbology.Code25, enabled: true)
        settings.setSymbology(SBSSymbology.UPC12, enabled: true)
        settings.setSymbology(SBSSymbology.QR, enabled: true)
        settings.setSymbology(SBSSymbology.Code39, enabled: true)
        settings.setSymbology(SBSSymbology.UPCE, enabled: true)
        settings.setSymbology(SBSSymbology.Code93, enabled: true)
        settings.setSymbology(SBSSymbology.Codabar, enabled: true)
        settings.setSymbology(SBSSymbology.MaxiCode, enabled: true)
        
        // set up double tap guesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
        backButton.hidden = false
        backButton.bringSubviewToFront(backButton)
        
       // let thePicker = SBSBarcodePicker(settings:settings);
        picker = SBSBarcodePicker(settings: settings)
        // set delegate to recieve scan events
        picker!.scanDelegate = self
        
        // set the allowed interface orientations. The value UIInterfaceOrientationMaskAll is the
        // default and is only shown here for completeness.
        picker!.allowedInterfaceOrientations = UIInterfaceOrientationMask.All;
        
        
        // Show scanner
        
        self.addChildViewController(picker!)
        self.view.addSubview(picker!.view)
        picker!.didMoveToParentViewController(self)
        
        picker!.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constaints to place the picker at the top of the controller with a heigh of 300 and the same width as the controller. Since this is not the aspect ration of the preview, some of the videp will be cut away on the top and the bottom
        
        let pickerView : UIView = self.picker!.view
      //  pickerView.pb_takeSnapshot()
      
        var views : [String:AnyObject] = ["pickerView" : pickerView]
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
            let topGuide = self.topLayoutGuide
            views = ["pickerView" : pickerView, "topGuide" : topGuide]
            self.view!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[topGuide][pickerView(700)]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views))
            
        } else {
            // there is no topLayoutGuide under iOS6
            self.view!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|(50)-[pickerView(self.view.bounds.height)]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views))
        }
        
    self.view!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[pickerView]|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views))
        
        picker!.startScanning()
//        picker = thePicker;
        // Start Scanning
       
        
       // self.presentViewController(picker!, animated: true, completion: nil)
        }
    
    func barcodePicker(picker: SBSBarcodePicker, didScan session: SBSScanSession) {
        print("AYY")
        session.stopScanning()
        
    
        let code : SBSCode = session.newlyRecognizedCodes[0] as! SBSCode
        
        if (code.symbology != SBSSymbology.Unknown){
        // code to handle barcode result
            
            
        dispatch_async(dispatch_get_main_queue()) {
            
            let requestURL : NSURL = NSURL(string: "https://api.outpan.com/v2/products/\((code.data)!)?apikey=f603e960da29067c4573079073426751")!
            
            let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
            
            let session = NSURLSession.sharedSession()

            
             let task = session.dataTaskWithRequest(urlRequest) {
                (data, response, error) -> Void in
                
                let httpResponse = response as! NSHTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200){
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                    
                    let name = (json!["name"] as! String)
                    
                    var tempData = [String:Any]() // creates a temporary array for the item info
                    tempData["name"] = name
                    tempData["price"] = 1.25
                    tempData["upcCode"] = code.data
                    
                    print(tempData)
                    GlobalData.items.append(tempData)
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
                } else {
                    print("NO INTERNET CONNECTION")
                }
            }
            task.resume()
            
        
            }
        }
        
            self.performSegueWithIdentifier("goBackToMainPage", sender: nil)

            
           // print("scanned: \(code.symbology), barcode: \(code.data)")
        
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
       // picker?.startScanning();
    }
    
    func overlayController(overlayController: SBSOverlayController, didCancelWithStatus status: [NSObject : AnyObject]?) {
        // called when user cancles barcode scan process
    }
    
    func doubleTapped(){
        performSegueWithIdentifier("goBackToMainPage", sender: nil)
    }
    
}