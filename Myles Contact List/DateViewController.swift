//
//  DateViewController.swift
//  Myles Contact List
//
//  Created by Makaveli Ohaya on 11/6/19.
//  Copyright © 2019 Myles Young. All rights reserved.
//

import UIKit

protocol DateControllerDelegate: class {
    func dateChanged(date: Date)
}

class DateViewController: UIViewController {
    weak var delegate: DateControllerDelegate?

    @IBOutlet weak var dtpDate: UIDatePicker!
    
    override func viewDidLoad() {
    super.viewDidLoad()

    let saveButton: UIBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: UIBarButtonItem.SystemItem.save,
        target: self,
        action: #selector(saveDate)
    )
        
    self.navigationItem.rightBarButtonItem = saveButton
    self.title = "Pick Birthdate"
}
        
    @objc func saveDate(){
        self.delegate?.dateChanged(date: dtpDate.date)
        let navController = self.navigationController
        navController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
