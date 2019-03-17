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
    
    fileprivate var name: String?
    fileprivate var age: Int?
    fileprivate var room_number: Int?
    fileprivate var sex: String?
    fileprivate var DTF: Bool?
    fileprivate var priority: Int?
    fileprivate var cruise_id: String?
    fileprivate var phone_number: Int?
    
    static let sharedInstance = UserDataModel()
    
    init(){
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
    
    
}
