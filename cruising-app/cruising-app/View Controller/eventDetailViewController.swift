//
//  eventDetailViewController.swift
//  cruising-app
//
//  Created by Peter Luo on 3/17/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import UIKit

class eventDetailViewController: UIViewController {

    var event_data: Event?
    var delegate: eventProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func dismissView(_ sender: UIButton) {
        self.delegate?.dismiss()
    }
    
    func loadEvent(data : Event){
        self
            .event_data = data
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
