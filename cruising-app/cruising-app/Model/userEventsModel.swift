//
//  userEventsModel.swift
//  cruising-app
//
//  Created by Peter Luo on 3/16/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

let userDataModel = UserDataModel.sharedInstance

class UserEventModel {
    
    fileprivate var name: String?
    fileprivate var event: String?
    fileprivate var user_id: String?
    fileprivate var event_id: String?
    fileprivate var cruise_id: String?
    
    static let sharedInstance = UserEventModel()
    
    init(){
        
    }
    
    var firestoreDatabase : Firestore {
        let database = Firestore.firestore()
        let settings = database.settings
        settings.areTimestampsInSnapshotsEnabled = true
        database.settings = settings
        return database
    }
}
