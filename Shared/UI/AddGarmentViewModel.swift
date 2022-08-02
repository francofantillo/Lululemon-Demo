//
//  AddGarmentViewModel.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-07-29.
//

import SwiftUI

extension AddGarmentView {
    
    class AddGarmentViewModel: ObservableObject {
        
        @Binding private(set) var inventoryItems: [Garment]
        @Binding private(set) var isSortedAlpha: Int
        @Binding private(set) var isPresented: Bool
        
        @Published var garment = ""
        
        init(inventoryItems: Binding<[Garment]>, isSortedAlpha: Binding<Int>, isPresented: Binding<Bool>){
            self._inventoryItems = inventoryItems
            self._isSortedAlpha = isSortedAlpha
            self._isPresented = isPresented
        }
        
        func addNewGarment(){
            let newItem = Garment(creationDate: Date(), name: garment)
            inventoryItems.append(newItem)
            let util = GarmentSorter()
            inventoryItems = util.sortGarments(isSortedAlpha: isSortedAlpha == 0, garments: inventoryItems)
        }
    }
}
