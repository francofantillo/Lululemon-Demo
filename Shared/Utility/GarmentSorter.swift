//
//  UtilityFunctions.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-07-29.
//

import Foundation

class GarmentSorter {
    
    func sortGarments(isSortedAlpha: Bool, garments: [Garment]) -> [Garment] {
        let sortedGarments = garments.sorted { (lhs, rhs) in
            if isSortedAlpha {
                return lhs.name < rhs.name
            }
            
            return lhs.creationDate < rhs.creationDate
        }
        return sortedGarments
    }
}
