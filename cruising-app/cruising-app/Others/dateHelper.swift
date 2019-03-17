//
//  dateHelper.swift
//  cruising-app
//
//  Created by Peter Luo on 3/17/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import Foundation

func today() -> Date {
    let date = Date()
    let calendar = Calendar.current
    var currentMonthComponents = calendar.dateComponents([.year,.month,.day], from: date)
    currentMonthComponents.day = calendar.component(.day, from: date)
    let today = calendar.date(from: currentMonthComponents)
    return today!
}

func currentMinute() -> Int{
    let currentTime = Calendar.current.dateComponents([.hour, .minute], from: Date())
    return currentTime.hour!*60+currentTime.minute!
}



func parseDateToString(date :Date) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MMM-yyyy"
    
    let dateString = formatter.string(from: Date())
    return dateString
}
//
//    func parseDateToTimeStamp(){
//
//    }
