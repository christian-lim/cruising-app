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

class EventModel {
    static let sharedInstance = EventModel()
    
    fileprivate var name: String?
    fileprivate var max_capcity: Int?
    fileprivate var attendance: Int?
    fileprivate var description: String?
    fileprivate var start_time: Date?
    fileprivate var end_time: Date?
    fileprivate var location: String?
    fileprivate var cruid_id: String?
    
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
