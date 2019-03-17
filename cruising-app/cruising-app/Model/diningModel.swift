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
    fileprivate var opening_time: Int?; // In total minutes, so 10 AM = 60*10 = 600
    fileprivate var closing_time: Int?; // In total minutes, so 8 PM = 60 * 20 = 1200
    // special case: 2AM = 60 * (2 + 24) = 1560
    fileprivate var menu: [FoodType:[FoodEntry]] = [:];
    
}

class DiningModel {
    static let sharedInstance = DiningModel();
    
    fileprivate var restaurant: Restaurant? = nil;
    fileprivate var restaurantList: [Restaurant] = [];
    
    init() {
        NotificationCenter.default.addObserver(self,selector: #selector(loadData), name: NSNotification.Name(rawValue: "FirebaseSetupDone"), object: nil)
    }
    
    var firestoreDatabase: Firestore {
        let database = Firestore.firestore();
        let settings = database.settings;
        settings.areTimestampsInSnapshotsEnabled = true;
        database.settings = settings;
        return database;
    }
    
    @objc func loadData() {
        let current_time = convertCurrentTime()
        let database = firestoreDatabase
        database.collection("Restaurant").whereField("opening_time", isLessThan: current_time).getDocuments() { (querySnapshot, err) in
            guard err == nil else {print("Error getting documents: \(err ?? "Failed" as! Error)");return}
            guard let querySnapshot = querySnapshot else {return}
            for document in querySnapshot.documents {
                self.restaurant = Restaurant(name: document["name"] as? String, opening_time: document["opening_time"] as? Int, closing_time: document["closing_time"] as? Int, menu: [:])
                self.restaurantList.append(self.restaurant!)
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "diningModelDidUpdate"), object: nil)
        }
        
    }
    
    func convertCurrentTime() -> Int {
        // Returns current time in minutes
        let hour = Calendar.current.component(.hour, from: Date())
        let minute = Calendar.current.component(.minute, from: Date())
        
        return (60 * hour) + minute
    }
    
}


