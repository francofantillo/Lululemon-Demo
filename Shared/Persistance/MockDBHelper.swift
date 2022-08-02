//
//  MockDBHelper.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-08-01.
//

import Foundation

class MockDBHelper: PersistanceDataService {
    func readDatabase() -> [Garment] {
        
        let garment1 = Garment(creationDate: createDate1(), name: "Shirt")
        let garment2 = Garment(creationDate: createDate2(), name: "Pants")
        let garment3 = Garment(creationDate: createDate3(), name: "Apple")
        var garments = [Garment]()
        garments.append(garment2)
        garments.append(garment1)
        garments.append(garment3)
        let test = [garment3, garment2, garment1]
        return test
    }
    
    func writeDatabase(garments: [Garment]) {
        
    }
    
    
    private func createDate1() -> Date {
        
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = 1980
        dateComponents.month = 7
        dateComponents.day = 11
        dateComponents.timeZone = TimeZone(abbreviation: "PST") // Japan Standard Time
        dateComponents.hour = 8
        dateComponents.minute = 34

        // Create date from components
        let userCalendar = Calendar(identifier: .gregorian) // since the components above (like year 1980) are for Gregorian
        let someDateTime = userCalendar.date(from: dateComponents)!
        return someDateTime
    }
    
    private func createDate2() -> Date {
        
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = 2000
        dateComponents.month = 7
        dateComponents.day = 15
        dateComponents.timeZone = TimeZone(abbreviation: "PST") // Japan Standard Time
        dateComponents.hour = 8
        dateComponents.minute = 34

        // Create date from components
        let userCalendar = Calendar(identifier: .gregorian) // since the components above (like year 1980) are for Gregorian
        let someDateTime = userCalendar.date(from: dateComponents)!
        return someDateTime
    }
    
    private func createDate3() -> Date {
        
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 7
        dateComponents.day = 15
        dateComponents.timeZone = TimeZone(abbreviation: "PST") // Japan Standard Time
        dateComponents.hour = 8
        dateComponents.minute = 34

        // Create date from components
        let userCalendar = Calendar(identifier: .gregorian) // since the components above (like year 1980) are for Gregorian
        let someDateTime = userCalendar.date(from: dateComponents)!
        return someDateTime
    }
}
