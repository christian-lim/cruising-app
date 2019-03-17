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
    fileprivate var name: String?
    fileprivate var max_capcity: Int?
    fileprivate var attendance: Int?
    fileprivate var description: String?
    fileprivate var start_time: Int?
    fileprivate var end_time: Int?
    fileprivate var location: String?
    fileprivate var cruise_id: String?
    fileprivate var date: Date?
}

class EventsModel {
    static let sharedInstance = EventsModel()
    
    fileprivate var eventList: [Event] = []
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: "FirebaseSetupDone"), object: nil)
    }
    
    func today() -> Date {
        let date = Date()
        let calendar = Calendar.current
        var currentMonthComponents = calendar.dateComponents([.year,.month,.day], from: date)
        currentMonthComponents.day = calendar.component(.day, from: date)
        let today = calendar.date(from: currentMonthComponents)
        return today!
    }
    
    func currentMinute() -> Int{
        let currentTime = Calendar.current.dateComponents([.hour, .minute], from: Date())
        return currentTime.hour!*60+currentTime.minute!
    }
    
    func parseDateToDate(){
        
    }
    
    func parseDateToTimeStamp(){
        
    }
    
    @objc func loadData(){
        let database = firestoreDatabase
        print(today())
        database.collection("Event").whereField("date", isGreaterThanOrEqualTo: today())
            .getDocuments() { (querySnapshot, err) in
                guard err == nil else {print("Error getting documents: \(err ?? "Failed" as! Error)");return}
                guard let querySnapshot = querySnapshot else {return}
                for document in querySnapshot.documents {
                    let data = document.data()
                    if let ending_time = data["end_time"] as? Int{
                        print(ending_time, self.currentMinute())
                        print(data["date"])
                        if ending_time > self.currentMinute(){
                            self.eventList.append(Event(name: data["name"] as? String, max_capcity: data["max_capacity"] as? Int, attendance: data["attendance"] as? Int, description: data["description"] as? String, start_time: data["start_time"] as?Int, end_time: data["end_time"] as? Int, location: data["location"] as? String, cruise_id: data["cruise_id"] as? String, date: (data["date"] as? Timestamp)?.dateValue()))
                        }
                    } else {print("Failed", self.currentMinute())}
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
