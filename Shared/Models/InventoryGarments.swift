//
//  InventoryItems.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-07-29.
//

import Foundation

class InventoryGarments: ObservableObject {
    @Published var garments = [Garment]()
}
