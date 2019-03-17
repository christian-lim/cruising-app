//
//  eventModel.swift
//  cruising-app
//
//  Created by Peter Luo on 3/16/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Event {
    var name: String?
    var max_capcity: Int?
    var attendance: Int?
    var description: String?
    var start_time: Int?
    var end_time: Int?
    var location: String?
    var cruise_id: String?
    var date: Date?
    var event_id: String?
}

class EventsModel {
    static let sharedInstance = EventsModel()
    
    fileprivate var EventList: [Date: [Event]] = [:]
    
    var eventList : [Date: [Event]] {
        return EventList
    }

    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: "FirebaseSetupDone"), object: nil)
    }
    var numberOfDays : Int {return self.EventList.keys.count}
    
    var numberOfEvents : Int {return Array(self.EventList.values).count}
    
    func numberOfEventsPerDay(section: Int) -> Int {
        return self.EventList[self.EventList.keys.sorted()[section]]!.count
    }
    
    func getEventByIndexPath(indexPath: IndexPath) -> Event{
        return self.EventList[self.EventList.keys.sorted()[indexPath.section]]![indexPath.row]
    }
    
    func getDate(section: Int) -> String{
        let date = self.EventList.keys.sorted()[section]
        return parseDateToString(date: date)
    }
    
    @objc func loadData(){
        let database = firestoreDatabase
        database.collection("Event").whereField("date", isGreaterThanOrEqualTo: today())
            .getDocuments() { (querySnapshot, err) in
                guard err == nil else {print("Error getting documents: \(err ?? "Failed" as! Error)");return}
                guard let querySnapshot = querySnapshot else {return}
                for document in querySnapshot.documents {
                    let data = document.data()
                    if let ending_time = data["end_time"] as? Int{
                        if ((((data["date"] as? Timestamp)?.dateValue())! == today()) && ending_time > currentMinute()) || (((data["date"] as? Timestamp)?.dateValue())! > today()){
                            if let thisDate = (data["date"] as? Timestamp)?.dateValue() {
                                if self.EventList.keys.contains(thisDate){
                                    self.EventList[thisDate]!.append(Event(name: data["name"] as? String, max_capcity: data["max_capacity"] as? Int, attendance: data["attendance"] as? Int, description: data["description"] as? String, start_time: data["start_time"] as?Int, end_time: data["end_time"] as? Int, location: data["location"] as? String, cruise_id: data["cruise_id"] as? String, date: thisDate, event_id: document.documentID))
                                }
                                self.EventList[thisDate] = [Event(name: data["name"] as? String, max_capcity: data["max_capacity"] as? Int, attendance: data["attendance"] as? Int, description: data["description"] as? String, start_time: data["start_time"] as?Int, end_time: data["end_time"] as? Int, location: data["location"] as? String, cruise_id: data["cruise_id"] as? String, date: thisDate, event_id: document.documentID)]
                            }
                            }
                    } else {print("Failed")}
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "eventModelDidUpdate"), object: nil)
        }
    }
    
    var firestoreDatabase : Firestore {
        let database = Firestore.firestore()
        let settings = database.settings
        settings.areTimestampsInSnapshotsEnabled = true
        database.settings = settings
        return database
    }
}
