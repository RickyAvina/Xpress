//
//  ViewControllerCameraPage.swift
//  Xpress
//
//  Created by Maricela Avina on 7/19/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerCameraPage: UIViewController, SBSScanDelegate, SBSOverlayControllerDidCancelDelegate {
    
    var picker : SBSBarcodePicker?
    
    @IBOutlet var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = SBSScanSettings.pre47DefaultSettings();
        settings.cameraFacingPreference = SBSCameraFacingDirection.__CAMERA_FACING_BACK
        
        // types of symbologies (types of barcodes)
        settings.setSymbology(SBSSymbology.EAN13, enabled: true)
        settings.setSymbology(SBSSymbology.UPC12, enabled: true)
        settings.setSymbology(SBSSymbology.QR, enabled: true)
        
        let thePicker = SBSBarcodePicker(settings:settings);
        
        // set delegate to recieve scan events
        picker?.scanDelegate = self
        
        // set the allowed interface orientations. The value UIInterfaceOrientationMaskAll is the
        // default and is only shown here for completeness.
        thePicker.allowedInterfaceOrientations = UIInterfaceOrientationMask.All;
        
        picker = thePicker;

        // Start Scanning
        picker?.startScanning()
        
        // Show scanner
        self.presentViewController(picker!, animated: true, completion: nil)
        
        }
    
    func barcodePicker(picker: SBSBarcodePicker, didScan session: SBSScanSession) {
        let recognized : [AnyObject] = session.newlyRecognizedCodes;
        let code : SBSCode = recognized.first as! SBSCode
        
        // code to handle barcode result
        print("scanned: \(code.symbology), barcode: \(code.data)")
        
    }
    
    func overlayController(overlayController: SBSOverlayController, didCancelWithStatus status: [NSObject : AnyObject]?) {
        // called when user cancles barcode scan process
    }
}