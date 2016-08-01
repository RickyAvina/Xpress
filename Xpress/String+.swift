//
//  String+.swift
//  Xpress
//
//  Created by Maricela Avina on 8/1/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import Foundation

extension String {
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}