//
//  Lululemon_DemoApp.swift
//  Shared
//
//  Created by Franco Fantillo on 2022-07-29.
//

import SwiftUI

@main
struct Lululemon_DemoApp: App {

    @StateObject private var inventoryItems = InventoryGarments()
    
    var body: some Scene {
        WindowGroup {

            ContentView()
                .environmentObject(inventoryItems)
        }
    }
}
