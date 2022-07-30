//
//  AddItemView.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-07-29.
//

import SwiftUI

struct AddGarmentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var inventoryItems: [Garment]
    @Binding var isSortedAlpha: Int
    @Binding var isPresented: Bool
    
    @State private var garment = ""
    
    var body: some View {
            
        if isPresented {
            
            
            VStack(alignment: .leading){
                
                ZStack{
                    Rectangle()
                        .frame(maxHeight: 40)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                    HStack{

                        Text("   ")
                        .padding()
                        Spacer()
                        Text("ADD")
                        Spacer()
                        Button(action: {
                            let newItem = Garment(creationDate: Date(), name: garment)
                            inventoryItems.append(newItem)
                            inventoryItems = UtilityFunctions.sortGarments(isSortedAlpha: isSortedAlpha == 0, garments: inventoryItems)
                            presentationMode.wrappedValue.dismiss()

                        }) {
                            Text("Save")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                }

                Text("Garment Name:")
                TextField("", text: $garment)
                    .accessibilityLabel("addShortDescription")
                    .textFieldStyle(.roundedBorder)
                Spacer()
            }
            .padding()
        } else {
            
            VStack(alignment: .leading){
                                
                Text("Garment Name:")
                TextField("", text: $garment)
                    .accessibilityLabel("addShortDescription")
                    .textFieldStyle(.roundedBorder)
                Spacer()
            }
            .padding()
            .navigationTitle(Text("ADD"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newItem = Garment(creationDate: Date(), name: garment)
                        inventoryItems.append(newItem)
                        inventoryItems = UtilityFunctions.sortGarments(isSortedAlpha: isSortedAlpha == 0, garments: inventoryItems)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                }
    
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddGarmentView(inventoryItems: Binding<[Garment]>.constant([Garment]()), isSortedAlpha: Binding<Int>.constant(0), isPresented: Binding<Bool>.constant(true))
        }
    }

