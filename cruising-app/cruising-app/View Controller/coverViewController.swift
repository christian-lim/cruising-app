//
//  ViewController.swift
//  cruising-app
//
//  Created by Christian Lim on 3/16/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import UIKit



class coverViewController: UIViewController {

    @IBOutlet weak var introduction: UILabel!
    
    let userDataModel = UserDataModel.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: "profileDidLoad"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func loadData(){
        self.introduction.text = "Hi " + (self.userDataModel.getName ?? "Brad") + "! You have the following events coming up:"
    }


}

