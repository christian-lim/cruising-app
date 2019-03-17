//
//  matchViewController.swift
//  cruising-app
//
//  Created by Peter Luo on 3/17/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import UIKit

class matchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    @IBOutlet weak var matchNameLabel: UILabel!
    @IBOutlet weak var matchSexLabel: UILabel!
    @IBOutlet weak var matchAgeLabel: UILabel!
    @IBOutlet weak var matchEventTableView: UITableView!
    
    let matchDataModel = MatchDataModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable), name: NSNotification.Name(rawValue: "matchProcessed") , object: nil)
        matchDataModel.getPersonalEventList()
        matchDataModel.getData()
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshTable(){
        
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
