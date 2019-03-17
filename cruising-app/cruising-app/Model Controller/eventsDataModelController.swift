//
//  eventsDataModelController.swift
//  cruising-app
//
//  Created by Christian Lim on 3/16/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore



class eventsDataModel {
    fileprivate var cruise_id: Int?;
    fileprivate var name: String?;
    fileprivate var description: String?;
    fileprivate var location: String?;
    fileprivate var start_time: Date?;
    fileprivate var end_time: Date?;
    fileprivate var attendance: Int?;
    fileprivate var max_capacity: Int?;
    
    var firestoreDatabase: Firestore {
        let database = Firestore.firestore();
        let settings = database.settings;
        settings.areTimestampsInSnapshotsEnabled = true;
        database.settings = settings;
        return database;
    }
    
    init() {
        let database = firestoreDatabase;
        
        database.collection("<#T##collectionPath: String##String#>")
    }
    
}
