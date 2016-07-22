//
//  Item.swift
//  Xpress
//
//  Created by Maricela Avina on 7/20/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import Foundation
import UIKit

class Item : UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var upcCode: UILabel!
}