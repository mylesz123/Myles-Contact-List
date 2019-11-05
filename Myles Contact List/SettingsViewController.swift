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
    
    //    WARNING !! this is what is preventing the preferences from getting saved.
    func sortSettings() {
        let settings = UserDefaults.standard
        settings.set("City", forKey: "sortField") //       getting a reference to the standard UserDefaults object
        settings.string(forKey: "sortField") ?? ""    //        retrieve value

        settings.set(true, forKey: "sortDirectionAscending")    //       save bool value for ASC order
        settings.bool(forKey: "sortDirectionAscending")    //    retrieve value
    }
    //    WARNING !! is not supposed to wrapped in function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        pickSortField.dataSource = self
        pickSortField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let settings = UserDefaults.standard
        switchAsc.setOn(settings.bool(forKey: Constants.kSortDirection), animated: true)
        
        let sortField = settings.string(forKey: Constants.kSortField)
        var i = 0
        for field in sortOrderItems {
            // if a row is found in the array, return that row
            if field == sortField {
                pickSortField.selectRow(i, inComponent: 0, animated: false)
            }
            i += 1
        }
        pickSortField.reloadAllComponents() // changes the picker view
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
        let sortField = sortOrderItems[row]
        let settings = UserDefaults.standard
        settings.set(sortField, forKey: Constants.kSortField)
        settings.synchronize()
        print("Chosen Item: \(sortOrderItems[row])")
    }
    
    @IBAction func sortDirectionChanged(_ sender: Any) {
        let settings = UserDefaults.standard
        settings.set(switchAsc.isOn, forKey: Constants.kSortDirection)
        settings.synchronize()
        print("Chosen Item: \(settings.bool(forKey: Constants.kSortDirection))")
    }
}
