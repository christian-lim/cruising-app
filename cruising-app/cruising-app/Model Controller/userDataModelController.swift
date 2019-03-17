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
import FirebaseAuth

class userDataModel{
    
    fileprivate var name: String?
    fileprivate var age: Int?
    fileprivate var room_number: Int?
    fileprivate var sex: String?
    fileprivate var DTF: Bool?
    fileprivate var priority: Int?
    fileprivate var user_id: String?
    fileprivate var cruise_id: String?
    fileprivate var phone_number: Int?
    
    static let sharedInstance = UserEventModel()
    
    init(){
        let database = firestoreDatabase
        database.collection("Account").whereField("userID", isEqualTo: Auth.auth().currentUser!.uid).getDocuments(){ (querySnapshot, err) in
            guard err == nil else {print("Error getting documents: \(err ?? "Failed" as! Error)");return}
            guard let querySnapshot = querySnapshot else {return}
            for document in querySnapshot.documents {
                
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
