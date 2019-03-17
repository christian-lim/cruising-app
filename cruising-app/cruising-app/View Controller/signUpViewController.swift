//
//  signUpViewController.swift
//  cruising-app
//
//  Created by Christian Lim on 3/17/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class signUpViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var sex: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func randomString(length: Int) -> String {
//        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//        return String((0..<length).map{ _ in letters.randomElement()! })
//    }
    
    func randomNumber() -> Int {
        return Int.random(in: 1..<1500)
    }
    
    @IBAction func signUp(_ sender: Any) {
        if (password.text! != confirmPassword.text!) {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Passwords did not match, please try again.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else {
            Auth.auth().createUser(withEmail: email.text!,  password:password.text!) {
                (authResult, err) in
                guard err == nil else {return}
                guard authResult?.user != nil else {return}
                let userInfo = Profile(name: self.name.text, age: Int(self.age.text ?? "999"), room_number:self.randomNumber(), sex: self.sex.text, DTF: false, priority: 0, cruise_id: "0"/*self.randomString(length: 6)*/, phone_number: Int(self.phoneNumber.text ?? "1234567890"), searchable: false)
                self.addUserInfo(profile: userInfo)
            }
            return;
        }
    }
    
    var firestoreDatabase : Firestore {
        let database = Firestore.firestore()
        let settings = database.settings
        settings.areTimestampsInSnapshotsEnabled = true
        database.settings = settings
        return database
    }
    
    func addUserInfo(profile: Profile){
        let database = firestoreDatabase
        
        do {
            database.collection("User").document(Auth.auth().currentUser!.uid).setData(try profile.asDictionary())
            NotificationCenter.default.post(name: Notification.Name(rawValue: "NewEntry"), object: nil)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
