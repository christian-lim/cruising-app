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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            }
            return;
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
