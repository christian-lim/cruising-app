//
//  eventDetailViewController.swift
//  cruising-app
//
//  Created by Peter Luo on 3/17/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import UIKit
import Firebase

class eventDetailViewController: UIViewController {

    var event_data: Event?
    var delegate: eventProtocol? = nil
    let userEventModel = UserEventModel.sharedInstance
    let userDataModel = UserDataModel.sharedInstance
    
    @IBOutlet weak var watchlistButton: UISwitch!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeRangeLabel: UILabel!
    
    @IBAction func watchListChange(_ sender: UISwitch) {
        let database = firestoreDatabase
        if sender.isOn {
            database.collection("user_event").document().setData([
                "name": userDataModel.getName ?? "NULL",
                "event": event_data?.name ?? "NULL",
                "user_id": Auth.auth().currentUser?.uid ?? "---",
                "cruise_id": event_data?.cruise_id ?? "---",
                "event_id": event_data?.event_id ?? "---"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        } else {
            var deleteIDs:[String] = []
            database.collection("user_event").whereField("user_id", isEqualTo: Auth.auth().currentUser?.uid ?? "---").whereField("event_id", isEqualTo: event_data?.event_id ?? "---").whereField("cruise_id", isEqualTo: event_data?.cruise_id ?? "---").getDocuments{ (querySnapshot, err) in
                guard err == nil else {print("Error getting documents: \(err ?? "Failed" as! Error)");return}
                guard let querySnapshot = querySnapshot else {return}
                for document in querySnapshot.documents {
                    deleteIDs.append(document.documentID)
                }
                for ID in deleteIDs{
                    database.collection("user_event").document(ID).delete()
                }
            }
        }
    }
    
    var firestoreDatabase : Firestore {
        let database = Firestore.firestore()
        let settings = database.settings
        settings.areTimestampsInSnapshotsEnabled = true
        database.settings = settings
        return database
    }
    
    func minutesToHours (minutes : Int) -> (String, Int?) {
        let minute = minutes%60
        let hours = (minutes/60)%24
        let extra = (minutes/60)/24
        let newDate = String(format: "%d:%d", minute, hours)
        return (newDate, extra)
    }
    
    func mergeDate(day: Date, start_time: Int, end_time:Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let (startHourString, extraStartDay) = minutesToHours(minutes: start_time)
        let (endHourString, extraEndDay) = minutesToHours(minutes: end_time)
        
        var dateComponent = DateComponents()
        dateComponent.day = extraStartDay
        let starDateString = formatter.string(from: Calendar.current.date(byAdding: dateComponent, to: day)!)
        
        dateComponent.day = extraEndDay
        let endDateString = formatter.string(from: Calendar.current.date(byAdding: dateComponent, to: day)!)
        
        return "Start:\(starDateString) \(startHourString)   End: \(endDateString) \(endHourString)"
    }
    
    func updateWatchList(){
        let database = firestoreDatabase
        database.collection("user_event").whereField("user_id", isEqualTo: Auth.auth().currentUser?.uid ?? "---").whereField("event_id", isEqualTo: event_data?.event_id ?? "---").whereField("cruise_id", isEqualTo: event_data?.cruise_id ?? "---").getDocuments { (querySnapshot, err) in
            guard err == nil else {print("Error getting documents: \(err ?? "Failed" as! Error)");return}
            guard let querySnapshot = querySnapshot else {return}
            if querySnapshot.documents.count == 0{
                self.watchlistButton.isOn = false
            } else {
                self.watchlistButton.isOn = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let event = event_data {
            descriptionTextField.text = event.description
            locationLabel.text = "Location: " + (event.location ?? "NULL")
            timeRangeLabel.text = mergeDate(day: event.date!, start_time: event.start_time!, end_time: event.end_time!)
            updateWatchList()
        }
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
