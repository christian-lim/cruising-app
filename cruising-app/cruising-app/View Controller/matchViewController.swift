//
//  matchViewController.swift
//  cruising-app
//
//  Created by Peter Luo on 3/17/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import UIKit

class matchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentMatch: matchDetail? = nil
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchDataModel.getNumberEventBySection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.matchEventTableView.dequeueReusableCell(withIdentifier: "eventMatchCell", for: indexPath) as! eventTableViewCell
        cell.eventNameLabel.text = self.matchDataModel.getEventNameByIndexPath(indexPath: indexPath)
        cell.eventLocationLabel.text = ""
        return cell
    }
    
    @IBOutlet weak var matchNameLabel: UILabel!
    @IBOutlet weak var matchSexLabel: UILabel!
    @IBOutlet weak var matchAgeLabel: UILabel!
    @IBOutlet weak var matchEventTableView: UITableView!
    
    let matchDataModel = MatchDataModel.sharedInstance
    
    override func viewDidLayoutSubviews() {
        restart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(restart), name: NSNotification.Name(rawValue: "matchProcessed") , object: nil)
        matchDataModel.getPersonalEventList()
        matchDataModel.getData()
        matchEventTableView.delegate = self
        matchEventTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @objc func restart(){
        if let data = self.matchDataModel.nextMatch() {
            currentMatch = data
            self.matchAgeLabel.text = String(data.age ?? 99)
            self.matchSexLabel.text = String(data.sex ?? "Nil")
            self.matchNameLabel.text = String(data.name ?? "Nil")
            self.matchEventTableView.reloadData()
        }
        else {
            currentMatch = nil
            self.matchAgeLabel.text = "---"
            self.matchSexLabel.text = "---"
            self.matchNameLabel.text = "No more match"
            self.matchEventTableView.isHidden = true
        }
    }
    @IBAction func nextMatch(_ sender: UIButton) {
        self.matchDataModel.processedMatch(action: true, userID: (currentMatch?.userID)!)
    }
    
    @IBAction func noMatch(_ sender: Any) {
        self.matchDataModel.processedMatch(action: false, userID: (currentMatch?.userID)!)
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
