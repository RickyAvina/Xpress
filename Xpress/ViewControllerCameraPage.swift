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
        settings.setSymbology(SBSSymbology.UPC12, enabled: true)
        settings.setSymbology(SBSSymbology.QR, enabled: true)
        
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
        var views : [String:AnyObject] = ["pickerView" : pickerView]
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
            let topGuide = self.topLayoutGuide
            views = ["pickerView" : pickerView, "topGuide" : topGuide]
            self.view!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[topGuide][pickerView(300)]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views))
            
        } else {
            // there is no topLayoutGuide under iOS6
            self.view!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|(50)-[pickerView(300)]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views))
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
        
        // code to handle barcode result
       // dispatch_async(dispatch_get_main_queue()) {
            print("scanned: \(code.symbology), barcode: \(code.data)")
       // }
        
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
       // picker?.startScanning();
    }
    
    func overlayController(overlayController: SBSOverlayController, didCancelWithStatus status: [NSObject : AnyObject]?) {
        // called when user cancles barcode scan process
    }
}