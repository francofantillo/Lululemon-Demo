//
//  Protocols.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-08-01.
//

import Foundation

protocol PersistanceDataService {
    
    func readDatabase() -> [Garment]
    func writeDatabase(garments: [Garment])
}
