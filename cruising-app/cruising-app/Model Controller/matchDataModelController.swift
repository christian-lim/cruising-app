//
//  matchDataModelController.swift
//  cruising-app
//
//  Created by Peter Luo on 3/17/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import Foundation
import Firebase

struct matchDetail {
    var name: String?
    var eventList: [String: String]? = [:]
    var age: Int?
    var sex: String?
    var userID: String?
    
}

struct rawDetail{
    var name: String?
    var eventName: String?
    var eventID: String?
    var age: Int?
    var sex: String?
    var userID: String?
}

class MatchDataModel{
    
    let globalDispatchGroup: DispatchGroup = DispatchGroup()
    
    fileprivate var personalEventList: [String
        
        ] = []
    fileprivate var matchList: [String: matchDetail] = [:]
    fileprivate var rejectList: [matchDetail] = []
    fileprivate var acceptList: [matchDetail] = []
    
    let userDataModel = UserDataModel.sharedInstance
    static let sharedInstance = MatchDataModel()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "personalEventProcessed"), object: nil)
    }
    
    func getNumberEventBySection(section: Int) -> Int{
        if matchList.keys.count == 0 {
            return 0
        }
        return (matchList[Array(matchList.keys)[section]]?.eventList?.count)!
    }
    
    func getEventNameByIndexPath(indexPath: IndexPath) -> String{
        return (Array( (matchList[Array(matchList.keys)[indexPath.section]]?.eventList!)!.values)[indexPath.row])
    }
    
    func getPersonalEventList() {
        self.personalEventList = []
        let database = firestoreDatabase
        database.collection("user_event").whereField("user_id", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() { (querySnapshot, err) in
                guard err == nil else {print("Error getting documents: \(err ?? "Failed" as! Error)");return}
                guard let querySnapshot = querySnapshot else {return}
            for document in querySnapshot.documents{
                let data = document.data()
                self.personalEventList.append(data["event_id"] as! String)
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "personalEventProcessed"), object: nil)
        }
    }
    
    @objc func getData() {
        matchList.removeAll()
        var rawDataList:[rawDetail] = []
        let database = firestoreDatabase
        for event_id in self.personalEventList{
            globalDispatchGroup.enter()
            database.collection("user_event").whereField("cruise_id", isEqualTo: userDataModel.getCruiseID ?? "---").whereField("event_id", isEqualTo: event_id).getDocuments() { (querySnapshot, err) in
                guard err == nil else {print("Error getting documents: \(err ?? "Failed" as! Error)");return}
                guard let querySnapshot = querySnapshot else {return}
                for document in querySnapshot.documents{
                    let data = document.data()
                    rawDataList.append(rawDetail(name: data["name"] as? String, eventName: data["event_name"] as? String, eventID: data["event_id"] as? String, age: data["age"] as? Int, sex: data["sex"] as? String, userID: data["user_id"] as? String))
                }
                self.globalDispatchGroup.leave()
            }
        }
        globalDispatchGroup.notify(queue: .main) {
            for rawData in rawDataList{
                if self.matchList.keys.contains(rawData.userID!) && !(self.matchList[rawData.userID!]?.eventList?.keys.contains(rawData.eventID ?? "---"))!{
                    self.matchList[rawData.userID!]?.eventList?[rawData.eventID ?? "---"] = rawData.eventName
                } else {
                    let personDetail = matchDetail(name: rawData.name ?? " ---", eventList: [rawData.eventID ?? "---" : rawData.eventName ?? "---"], age: rawData.age ?? 999, sex: rawData.sex ?? "---", userID: rawData.userID ?? "---")
                    self.matchList[personDetail.userID ?? "---"] = personDetail;
                }
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "matchProcessed"), object: nil)
        }
    }
    
    func nextMatch() -> matchDetail?{
        if self.matchList.values.count == 0 {
            return nil
        }
        let data = Array(self.matchList.values)[0]
        return data
    }
    
    func processedMatch(action: Bool, userID: String) {
        if action {
            self.acceptList.append(self.matchList[userID]!)
        } else {
            self.rejectList.append(self.matchList[userID]!)
        }
        self.matchList[userID] = nil
        NotificationCenter.default.post(name: Notification.Name(rawValue: "matchProcessed"), object: nil)
    }
    
    var firestoreDatabase : Firestore {
        let database = Firestore.firestore()
        let settings = database.settings
        settings.areTimestampsInSnapshotsEnabled = true
        database.settings = settings
        return database
    }
}
