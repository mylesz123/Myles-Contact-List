//
//  SettingsViewController.swift
//  Myles Contact List
//
//  Created by Myles Young on 11/2/19.
//  Copyright © 2019 Myles Young. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var switchAsc: UISwitch!
    @IBOutlet weak var pickSortField: UIPickerView!
    
    let sortOrderItems: Array<String> = [
        "ContactName", "City", "Birthday"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickSortField.dataSource = self
        pickSortField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
/*    UIPicker Delegates and data source methods Data Sources*/
    
//    return # of rows to display
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
//    returns number of rows in picker
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOrderItems.count
    }

//    set value that is displayed in each row in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOrderItems[row]
    }
    
//    print the item that was selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Chosen Item: \(sortOrderItems[row])")
    }
    
    @IBAction func sortDirectionChanged(_ sender: Any) {
    }
}
