//
//  diningModel.swift
//  cruising-app
//
//  Created by Christian Lim on 3/16/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

enum FoodType {
    case breakfast;
    case lunch;
    case dinner;
}

struct FoodEntry {
    fileprivate var name: String?;
    fileprivate var price: Double?;
    fileprivate var type: FoodType?;
    
}

struct Restaurant {
    fileprivate var name: String?;
    fileprivate var opening_time: Date?;
    fileprivate var closing_time: Date?;
    fileprivate var menu: [FoodEntry] = [];
    
}

class DiningModel {
    static let sharedInstance = DiningModel();
    
    fileprivate var restaurantList: [Restaurant] = [];
    
    init() {
        
    }
    
    var firestoreDatabase: Firestore {
        let database = Firestore.firestore();
        let settings = database.settings;
        settings.areTimestampsInSnapshotsEnabled = true;
        database.settings = settings;
        return database;
    }
}

