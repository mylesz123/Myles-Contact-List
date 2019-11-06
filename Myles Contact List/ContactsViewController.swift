//
//  FirstViewController.swift
//  Myles Contact List
//
//  Created by Myles Young on 11/2/19.
//  Copyright © 2019 Myles Young. All rights reserved.
//

import UIKit
import CoreData
class ContactsViewController: UIViewController, UITextFieldDelegate, DateControllerDelegate{
    func dateChanged(date: Date) {if currentContact != nil {
        currentContact!.birthday = date as NSDate? as Date?
                appDelegate.saveContext()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                BirthDate.text = formatter.string(from: date)
            }
        }
    
    
    var currentContact: Contact?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var sgmtEditMode: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    //@IBOutlet weak var sgmtSwitchEditMode: UISwitch!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtHomePhone: UITextField!
    @IBOutlet weak var txtCellPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var BirthDate: UILabel!
    @IBOutlet weak var ChangeButton: UIButton!
    
    
    /*called anytime the value of the Segmented Control is changed, but the method call doesn’t indicate the current value of the control, so you need to add an outlet to be able to reference and read the value.*/
    @IBAction func changeToEditMode(_ sender: Any) {
        let textFields: [UITextField] = [
            txtName, txtAddress, txtCity, txtState, txtZip, txtHomePhone, txtCellPhone, txtEmail
        ]

        if sgmtEditMode.selectedSegmentIndex == 0 { //View Mode
            for textField in textFields { 
                textField.isEnabled = false
                textField.borderStyle = UITextField.BorderStyle.none
                //                textField.borderStyle = UITextBorderStyle.none --> OLD CODE 🤷🏾‍♂️

            }
            ChangeButton.isHidden = true
            navigationItem.rightBarButtonItem = nil
        }
        else if sgmtEditMode.selectedSegmentIndex == 1 { //Edit Mode
            for textField in textFields {
                textField.isEnabled = true
                textField.borderStyle = UITextField.BorderStyle.roundedRect
            }
            ChangeButton.isHidden = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                           target: self,
                                                                           action: #selector(self.saveContact))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      changeToEditMode(self)
        
        let textFields: [UITextField] = [ txtName, txtCity,txtAddress,txtState,txtZip,txtHomePhone,txtCellPhone,txtEmail]
        for textfield in textFields {
            textfield.addTarget(self,action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)), for: UIControl.Event.editingDidEnd)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        currentContact?.contactName = txtName.text
        currentContact?.streetAddress = txtAddress.text
        currentContact?.city = txtCity.text
        currentContact?.state = txtState.text
         currentContact?.zipCode = txtZip.text
        currentContact?.cellNumber = txtCellPhone.text
        currentContact?.phoneNumber = txtHomePhone.text
       currentContact?.email = txtEmail.text
        return true
        
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // When the scene is about to appear, a method is called to register the code to listen for notifications that the keyboard has been displayed.
        self.registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardNotifications()
    }
    @objc func saveContact() {
          if currentContact == nil {
              let context = appDelegate.persistentContainer.viewContext
              currentContact = Contact(context: context)
          }
          appDelegate.saveContext()
          sgmtEditMode.selectedSegmentIndex = 0
          changeToEditMode(self)
      }
    
    /*This method registers the code for notifications and tells the system to execute the appropriate method when the event occurs.*/
    func registerKeyboardNotifications() {
       NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardDidShow(notification:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func unregisterKeyboardNotifications() {
       NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        
//        get existing ConsentTnset for the scrollView and set the bottom prop to be the height of the keyboard
        var contentInset = self.scrollView.contentInset
        contentInset.bottom = keyboardSize.height
        
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = contentInset
    }
    
    /*When the keyboard disappears, the scroll view’s content insert values are set back to the original values.*/
    @objc func keyboardWillHide(notification: NSNotification) {
        var contentInset = self.scrollView.contentInset
        contentInset.bottom = 0
        
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if(segue.identifier == "segueContactDate"){
        let dateController = segue.destination as! DateViewController
        dateController.delegate = self
    }

}

}
