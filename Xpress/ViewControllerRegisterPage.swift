//
//  ViewControllerRegisterPage.swift
//  Xpress
//
//  Created by Maricela Avina on 7/18/16.
//  Copyright © 2016 RickyAvina. All rights reserved.
//

import UIKit

class ViewControllerRegisterPage: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet var firstNameTextField: UITextField!
    
    @IBOutlet weak var midleInitialLabel: UILabel!
    @IBOutlet var middleInitialPicker: UIPickerView!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet var lastNameTextField: UITextField!

    var middleInitialPickerData : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.middleInitialPicker.delegate = self
        self.middleInitialPicker.dataSource = self
        middleInitialPickerData = ["A.", "B.", "C.", "D.", "E.", "F.", "G.", "H.", "I.", "J.", "K.", "L.", "M.", "N.", "O.", "P.", "Q.", "R.", "S.", "T.", "U.", "V.", "W.", "X.", "Y.", "Z."]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // The number of colums of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // the number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return middleInitialPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return middleInitialPickerData[row]
    }

}
