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
        
        init(){
            persistData(phase: .active)
        }
        
        func removeGarments(index: IndexSet){
            garments.remove(atOffsets: index)
            updateGarments()
        }
        
        func updateGarments(){
            
            let util = UtilityFunctions()
            garments = util.sortGarments(isSortedAlpha: isSortedAlpha == 0, garments: garments)
            
            print(isSortedAlpha)
        }
        
        func persistData(phase: ScenePhase){
            let dbHelper = DBHelper()
            
            if phase == .active {
                dbHelper.readDatabase(garments: &garments)
                updateGarments()
                
            } else if phase == .inactive {
                dbHelper.writeDatabase(garments: &garments)
                updateGarments()
            }
        }
    }
}
