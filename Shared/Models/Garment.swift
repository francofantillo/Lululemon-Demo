//
//  Item.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-07-29.
//

import Foundation

struct Garment: Identifiable, Hashable {
    
    let id = UUID()
    let creationDate: Date
    let name: String
}
