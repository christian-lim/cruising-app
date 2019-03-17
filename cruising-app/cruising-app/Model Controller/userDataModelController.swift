//
//  userDataModel.swift
//  cruising-app
//
//  Created by Peter Luo on 3/16/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserDataModel{
    
    fileprivate var name: String? = nil
    fileprivate var age: Int? = nil
    fileprivate var room_number: Int? = nil
    fileprivate var sex: String? = nil
    fileprivate var DTF: Bool? = nil
    fileprivate var priority: Int? = nil
    fileprivate var cruise_id: String? = nil
    fileprivate var phone_number: Int? = nil
    fileprivate var searchable: Bool? = nil
    
    static let sharedInstance = UserDataModel()
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: "FirebaseSetupDone"), object: nil)
        
    }

    @objc func loadData() {
        let database = firestoreDatabase
        database.collection("User").document("userID"/*Auth.auth().currentUser!.uid*/).getDocument(){ (document, err) in
            guard err == nil else {print("Error getting documents: \(err ?? "Failed" as! Error)");return}
            if let document = document, document.exists {
                let data = document.data()!
                self.name = data["name"] as? String
                self.age = data["age"] as? Int
                self.room_number = data["room_number"] as? Int
                self.sex = data["sex"] as? String
                self.DTF = data["DTF"] as? Bool
                self.priority = data["priority"] as? Int
                self.cruise_id = data["cruise_id"] as? String
                self.phone_number = data["phone_number"] as? Int
                self.searchable = data["searchable"] as? Bool
                NotificationCenter.default.post(name: Notification.Name(rawValue: "profileDidLoad"), object: nil)
            } else {
                print("Document does not exist")
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
    
    var getName: String?{
        return self.name
    }
    
    var getAge: Int?{
        return self.age
    }
    
    var getRoomNumber: Int? {
        return self.room_number
    }
    
    var getSex: String? {
        return self.sex
    }
    
    var isDTF: Bool?{
        return self.DTF
    }
    
    var getPriority: Int? {
        return self.priority
    }
    
    var getCruiseID: String?{
        return self.cruise_id
    }
    
    var getPhoneNumber: Int? {
        return self.phone_number
    }
    
    var isSearchable: Bool?{
        return self.searchable
    }
    
    
}
