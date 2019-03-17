//
//  loginViewController.swift
//  cruising-app
//
//  Created by Christian Lim on 3/17/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class loginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginButton(_ sender: Any) {
        guard let password = password.text else {return}
        guard let email = email.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, err) in
            guard err == nil else {return}
            guard (authResult?.user) != nil else {return}
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
