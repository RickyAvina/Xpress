//
//  ViewControllerItemDescription.swift
//  Xpress
//
//  Created by Maricela Avina on 8/1/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerDetailPage : UIViewController {
    
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemDescriptionLabel: UILabel!
    
    static var name : String?
    static var desc : String?
    
    override func viewDidLoad() {
        itemNameLabel.text = ViewControllerDetailPage.name!
        itemDescriptionLabel.text = ViewControllerDetailPage.desc!
    }
}