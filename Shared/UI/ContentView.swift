//
//  ContentView.swift
//  Shared
//
//  Created by Franco Fantillo on 2022-07-29.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.scenePhase) var scenePhase
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var inventoryGarments: InventoryGarments
    
    @State private var isSortedAlpha = 0
    @State private var showingAddGarmentSheet = false
    
    init(){
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .gray
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
        
    var body: some View {
 
        NavigationView {
            
            
            VStack(spacing: 12){

                let indexIndices = inventoryGarments.garments.indices
                let items = inventoryGarments.garments
                Picker(selection: $isSortedAlpha , label: Text("")) {
                    Text("Alpha").tag(0)
                    Text("Creation Time").tag(1)
                }
                .pickerStyle(.segmented)
                .onChange(of: isSortedAlpha) { tag in
                    inventoryGarments.garments = UtilityFunctions.sortGarments(isSortedAlpha: (isSortedAlpha == 0),garments: inventoryGarments.garments)
                }
                .padding(.top, 8)
                .padding(.leading, 8)
                .padding(.trailing, 8)
                    
                let itemIndexPairs = Array(zip(items, indexIndices))
                List {

                    // can identify each element in a collection
                    ForEach(itemIndexPairs, id:\.0.id, content: { item, itemIndex in

                        ItemRow(item: item)
                    })
                    
                    .onDelete(perform: {indexSet in inventoryGarments.garments.remove(atOffsets: indexSet)
                        inventoryGarments.garments = UtilityFunctions.sortGarments(isSortedAlpha: (isSortedAlpha == 0),garments: inventoryGarments.garments)
                    })
                    
                }
                
                .listStyle(PlainListStyle())
                .navigationTitle("List")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        // Push view to stack
//                        let inventoryItemsWrapper = $inventoryGarments
//                        let itemBinding = inventoryItemsWrapper.garments
//                        NavigationLink(destination: AddGarmentView(inventoryItems: itemBinding, isSortedAlpha: $isSortedAlpha, isPresented: Binding<Bool>.constant(false))){
//                            Image(systemName: "plus.circle")
//                                .foregroundColor(colorScheme == .dark ? .white : .black)
//                        }
                        
                        // Present View Modally
                        Button(action: {
                            showingAddGarmentSheet = true
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                }
                
            }
            // add the .onChange modifier to one of your child views in each of your three views
            .onChange(of: scenePhase) { newPhase in
                
                let dbHelper = DBHelper()
                
                if newPhase == .active {
                    dbHelper.readDatabase(garments: &inventoryGarments.garments)
                    inventoryGarments.garments = UtilityFunctions.sortGarments(isSortedAlpha: (isSortedAlpha == 0), garments: inventoryGarments.garments)
                    
                } else if newPhase == .inactive {
                    dbHelper.writeDatabase(garments: &inventoryGarments.garments)
                    inventoryGarments.garments = UtilityFunctions.sortGarments(isSortedAlpha: (isSortedAlpha == 0), garments: inventoryGarments.garments)
                }
            }
            .sheet(isPresented: $showingAddGarmentSheet) {
                let inventoryItemsWrapper = $inventoryGarments
                // a binding to an array of items
                let itemBinding = inventoryItemsWrapper.garments
                AddGarmentView(inventoryItems: itemBinding, isSortedAlpha: $isSortedAlpha, isPresented: Binding<Bool>.constant(true))
            }
        }
    }
}

struct ItemRow: View {
    let item: Garment
    var body: some View {
        VStack(alignment: .leading){
                Text(item.name)
                .accessibilityLabel("shortDescription")
                .accessibilityValue(item.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let inventoryItems = InventoryGarments()
        ContentView()//(inventoryItems: inventoryItems) changed Inventory2
            .environmentObject(inventoryItems)
    }
}
