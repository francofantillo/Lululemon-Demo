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
    
    @StateObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel = .init(garmentSource: DBHelper())){
        _viewModel = StateObject(wrappedValue: viewModel)
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .gray
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
        
    var body: some View {
 
        NavigationView {
            
            
            VStack(spacing: 12){

                let items = viewModel.garments
                Picker(selection: $viewModel.isSortedAlpha , label: Text("")) {
                    Text("Alpha").tag(0)
                    Text("Creation Time").tag(1)
                }
                .pickerStyle(.segmented)
                .onChange(of: viewModel.isSortedAlpha) { tag in
                    viewModel.updateGarments()
                }
                .padding(.top, 8)
                .padding(.leading, 8)
                .padding(.trailing, 8)

                List {

                    // can identify each element in a collection
                    ForEach(items, id:\.self, content: { item in

                        ItemRow(item: item)
                    })

                    .onDelete(perform: {indexSet in
                        viewModel.removeGarments(index: indexSet)
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
//                        let viewModel = AddGarmentView.AddGarmentViewModel(inventoryItems: itemBinding, isSortedAlpha: $isSortedAlpha, isPresented: Binding<Bool>.constant(false))
//                        NavigationLink(destination: AddGarmentView(viewModel: viewModel)){
//                            Image(systemName: "plus.circle")
//                                .foregroundColor(colorScheme == .dark ? .white : .black)
//                        }

                        // Present View Modally
                        Button(action: {
                            viewModel.showingAddGarmentSheet = true
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                }
                
            }
            .onChange(of: scenePhase) { newPhase in
                viewModel.persistData(phase: newPhase)
            }
            .sheet(isPresented: $viewModel.showingAddGarmentSheet) {

                let viewModel = AddGarmentView.AddGarmentViewModel(inventoryItems: $viewModel.garments,
                                                                   isSortedAlpha: $viewModel.isSortedAlpha,
                                                                   isPresented: Binding<Bool>.constant(true))
                AddGarmentView(viewModel: viewModel)
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
        ContentView(viewModel: ContentView.ContentViewModel(garmentSource: DBHelper()))
    }
}
