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

struct Profile : Codable{
    var name: String? = nil
    var age: Int? = nil
    var room_number: Int? = nil
    var sex: String? = nil
    var DTF: Bool? = nil
    var priority: Int? = nil
    var cruise_id: String? = nil
    var phone_number: Int? = nil
    var searchable: Bool? = nil
    
}

class UserDataModel{
    
    fileprivate var profile :Profile? = nil
    
    static let sharedInstance = UserDataModel()
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: "FirebaseSetupDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: "NewEntry"), object: nil)
    }

    @objc func loadData() {
        let database = firestoreDatabase
        database.collection("User").document(Auth.auth().currentUser!.uid).getDocument(){ (document, err) in
            guard err == nil else {print("Error getting documents: \(err ?? "Failed" as! Error)");return}
            if let document = document, document.exists {
                let data = document.data()!
                self.profile = Profile(name: data["name"] as? String, age: data["age"] as? Int, room_number: data["room_number"] as? Int, sex: data["sex"] as? String, DTF: data["DTF"] as? Bool, priority: data["priority"] as? Int, cruise_id: data["cruise_id"] as? String, phone_number: data["phone_number"] as? Int, searchable: data["searchable"] as? Bool)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "profileDidLoad"), object: nil)
            } else {
                print("Document does not exist")
            }
        }
    }

    func updateSingleFirebase(data: Any?, operation: updateOperation) {
        guard let data = data else {return}
        let database = firestoreDatabase
        switch operation{
        case .updateDTF:
            self.profile?.DTF = data as? Bool
            database.collection("User").document(Auth.auth().currentUser!.uid).updateData(["DTF": data])
        case .updatePhoneNumber:
            self.profile?.phone_number = data as? Int
            database.collection("User").document(Auth.auth().currentUser!.uid).updateData(["phone_number": data])
        case .updateSearchable:
            self.profile?.searchable = data as? Bool
            database.collection("User").document(Auth.auth().currentUser!.uid).updateData(["searchable": data])
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
        return self.profile?.name
    }
    
    var getAge: Int?{
        return self.profile?.age
    }
    
    var getRoomNumber: Int? {
        return self.profile?.room_number
    }
    
    var getSex: String? {
        return self.profile?.sex
    }
    
    var isDTF: Bool?{
        return self.profile?.DTF
    }
    
    var getPriority: Int? {
        return self.profile?.priority
    }
    
    var getCruiseID: String?{
        return self.profile?.cruise_id
    }
    
    var getPhoneNumber: Int? {
        return self.profile?.phone_number
    }
    
    var isSearchable: Bool?{
        return self.profile?.searchable
    }
    
    
}
