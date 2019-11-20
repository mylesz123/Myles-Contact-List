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
        "contactName", "city", "birthday","email"
    ]
    let sortsecond: Array<String> = [
       "address", "state","zipcode"
    ]
    
    //    this is what is preventing the preferences from getting saved.
    func sortSettings() {
        let settings = UserDefaults.standard
        settings.set("City", forKey: "sortField") //       getting a reference to the standard UserDefaults object
        settings.string(forKey: "sortField") ?? ""    //        retrieve value

        settings.set(true, forKey: "sortDirectionAscending")    //       save bool value for ASC order
        settings.bool(forKey: "sortDirectionAscending")    //    retrieve the  value
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
        let sortField2 = settings.string(forKey: Constants.kSortField)
        
        var i = 0
        for field in sortOrderItems {
            // if a row is found in the array,then return that row
            if field == sortField {
                pickSortField.selectRow(i, inComponent: 0, animated: false)
            }
            i += 1
        }
        pickSortField.reloadComponent(0) // changes the picker view
        
        var j = 0
            for field in sortOrderItems {
                // if a row is found in the array,then return that row
                if field == sortField {
                    pickSortField.selectRow(i, inComponent: 1, animated: false)
                }
                j += 1
            }
            pickSortField.reloadComponent(1) // changes the picker view
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let device = UIDevice.current
        print("Device Info:")
        print("Name: \(device.name)")
        print("Model: \(device.model)")
        print("System Name: \(device.systemName)")
        print("System Version: \(device.systemVersion)")
        print("Identifier: \(device.identifierForVendor!)")
        
        let orientation: String
        switch device.orientation {
        case .faceDown:
            orientation = "Face Down"
        case .landscapeLeft:
            orientation = "Landscape Left"
        case .portrait:
            orientation="Portrait"
        case .landscapeRight:
            orientation = "Landscape Right"
        case .faceUp:
            orientation = "Face Up"
        case .portraitUpsideDown:
            orientation = "Portrait Upside Down"
        case .unknown:
            orientation = "Unknown Orientation"
        }
        print("Orientation: \(orientation)")
       
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
/*    UIPicker, Delegates, andthe data source methods */
    
//    number of rows to display
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
//    returns number of rows in picker
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
        return sortOrderItems.count
        }
        return sortsecond.count
    }

//    set value that is displayed in each row in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
        return sortOrderItems[row]
    }
        return sortsecond[row]
    }
//    print the item that was selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sortField = sortOrderItems[pickerView.selectedRow(inComponent: 0)]
        let sortField2 = sortsecond[pickerView.selectedRow(inComponent: 1)]
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
