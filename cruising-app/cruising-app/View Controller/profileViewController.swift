//
//  profileViewController.swift
//  cruising-app
//
//  Created by Peter Luo on 3/16/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import UIKit
import Firebase

class profileViewController: UIViewController {

    let userDataModel = UserDataModel.sharedInstance
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dtfPrefSwitch: UISwitch!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var searchableSwitch: UISwitch!
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: "profileDidLoad"), object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(profileViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(profileViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        loadData()
        // Do any additional setup after loading the view.
    }
    
//    @objc func isGoodPhoneNumber(_ sender: UITapGestureRecognizer){
//        if self.phoneNumberTextField.text!.count != 10 {
//            self.showToast(message: "Invalid phone number, should have a 10 digit entry")
//        } else {
//            self.view.endEditing(_:)
//        }
//    }
    
    @objc func loadData(){
        self.nameLabel.text = userDataModel.getName ?? ""
        self.sexLabel.text = userDataModel.getSex ?? ""
        self.ageLabel.text = String(userDataModel.getAge ?? 0)
        if let isDTF = userDataModel.isDTF {
            self.dtfPrefSwitch.isOn = isDTF
        } else {
            self.dtfPrefSwitch.isOn = false
        }
        self.phoneNumberTextField.text = String(self.userDataModel.getPhoneNumber ?? 0000000000)
        if let isSearchable = userDataModel.isSearchable{
            self.searchableSwitch.isOn = isSearchable
        } else{
            self.searchableSwitch.isOn = false
        }
    }
    
    @IBAction func dtfPrefDidChange(_ sender: UISwitch) {
        self.userDataModel.updateSingleFirebase(data: self.dtfPrefSwitch.isOn, operation: updateOperation.updateDTF)
    }
    @IBAction func searchableDidSwitch(_ sender: UISwitch) {
        self.userDataModel.updateSingleFirebase(data: self.searchableSwitch.isOn, operation: updateOperation.updateSearchable)
    }
    @IBAction func phoneNumberDidChange(_ sender: UITextField) {
        self.userDataModel.updateSingleFirebase(data: Int(self.phoneNumberTextField.text!), operation: updateOperation.updatePhoneNumber)
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
