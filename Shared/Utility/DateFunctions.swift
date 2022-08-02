//
//  DateFunctions.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-07-29.
//

import Foundation

class DateFunctions {
    
    func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func convertStringToDate(dateString: String)-> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        guard let date = dateFormatter.date(from:dateString) else {
            return convertStringToDateNoMilliseconds(dateString: dateString)
        }
        return date
    }
    
    func convertStringToDateNoMilliseconds(dateString: String)-> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:dateString)!
        return date
    }
}
