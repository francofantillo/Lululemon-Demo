//
//  ContentViewModel.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-07-29.
//

import SwiftUI

extension ContentView {
    
    class ContentViewModel: ObservableObject {
        
        @Published var garments = [Garment]()
        @Published var isSortedAlpha: Int = 0
        @Published var showingAddGarmentSheet = false
        
        let garmentSource: PersistanceDataService
        
        init(garmentSource: PersistanceDataService){
            self.garmentSource = garmentSource
            persistData(phase: .active)
        }
        
        func removeGarments(index: IndexSet){
            garments.remove(atOffsets: index)
            updateGarments()
        }
        
        func updateGarments(){
            
            let util = GarmentSorter()
            garments = util.sortGarments(isSortedAlpha: isSortedAlpha == 0, garments: garments)
            
            print(isSortedAlpha)
        }
        
        func persistData(phase: ScenePhase){
            
            if phase == .active {
                garments = garmentSource.readDatabase()
                updateGarments()
                
            } else if phase == .inactive {
                garmentSource.writeDatabase(garments: garments)
                updateGarments()
            }
        }
    }
}
