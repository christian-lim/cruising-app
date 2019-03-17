//
//  profileViewController.swift
//  cruising-app
//
//  Created by Peter Luo on 3/16/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    @objc func loadData(){
        self.nameLabel.text = userDataModel.getName
        self.sexLabel.text = userDataModel.getSex
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
    }
    @IBAction func searchableDidSwitch(_ sender: UISwitch) {
    }
    @IBAction func phoneNumberDidChange(_ sender: UITextField) {
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
