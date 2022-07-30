//
//  DateFunctions.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-07-29.
//

import Foundation

class DateFunctions {
    
    struct MyDateComponents {
        let year: String
        let month: String
        let day: String
        let dayName: String
        let hour: String
        let minute: String
        let AMorPM: String
        
        init(year:String, month: String, day: String, dayName: String, hour: String, minute: String, AMorPM: String) {
            self.year = year
            self.month = month
            self.day = day
            self.dayName = dayName
            self.hour = hour
            self.minute = minute
            self.AMorPM = AMorPM
        }
    }
    
    static func getCurrentDate()-> Date {
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.hour = Calendar.current.component(.hour, from: now)
        nowComponents.minute = Calendar.current.component(.minute, from: now)
        nowComponents.second = Calendar.current.component(.second, from: now)
        nowComponents.timeZone = NSTimeZone.local
        now = calendar.date(from: nowComponents)!
        return now as Date
    }
    
    static func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func convertStringToDate(dateString: String)-> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        guard let date = dateFormatter.date(from:dateString) else {
            return convertStringToDateNoMilliseconds(dateString: dateString)
        }
        return date
    }
    
    static func convertStringToDateNoMilliseconds(dateString: String)-> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:dateString)!
        return date
    }
    
    static func getDayName(date: Date)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
    
    static func convertDate(isoDate: String)-> MyDateComponents{
        
        let date = convertStringToDate(dateString: isoDate)
        let year = getYear(date: date)
        let month = getMonth(date: date)
        let day = getDay(date: date)
        let dayName = getDayName(date: date)
        var hour = getHour(date: date)
        let minute = getMinute(date: date)
        var AMorPM = "AM"
        
        if hour >= 12 {
            AMorPM = "PM"
        }
        
        if hour == 0 {
            hour = 12
        }
        
        if hour > 12 {
            hour = hour - 12
        }
        
        let returnDateComponents = MyDateComponents(year: year, month: month, day: day, dayName: dayName, hour: String(hour), minute: minute, AMorPM: AMorPM)
        return returnDateComponents
    }
    
    static func getReadableStringMonthDayYear(date: String) -> String{
            
        let components = DateFunctions.convertDate(isoDate: date)
        let dateString = components.month + " " +
            components.day + ", " +
            components.year// + " " +
    //            components.hour + ":" +
    //            components.minute + " " +
    //            components.AMorPM
        return dateString
    }
    
    static func getReadableStringDayOfWeek(date: String) -> String{
            
        let components = DateFunctions.convertDate(isoDate: date)
        let dateString = components.dayName
        return dateString
    }
    
    static func getReadableStringTime(date: String) -> String{
            
        let components = DateFunctions.convertDate(isoDate: date)
        let dateString = components.hour + ":" + components.minute + " " + components.AMorPM
        return dateString
    }
    
    private static func getYear(date: Date) -> String{
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return String(year)
    }
    
    private static func getMonth(date: Date)-> String{
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        
        switch month {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return ""
        }
    }
    
    private static func getDay(date: Date)-> String{
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        return String(day)
    }
    
    private static func getHour(date: Date)-> Int{
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    }
    
    private static func getMinute(date: Date)-> String{
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        if minutes < 10 {
            return "0" + String(minutes)
        }
        return String(minutes)
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
