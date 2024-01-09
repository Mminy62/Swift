//
//  FireStoreView.swift
//  FirebaseDemo
//
//  Created by 박준영 on 1/5/24.
//

import SwiftUI

struct FireStoreView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var restaurantStore = RestaurantStore.shared
    @State var name: String = ""
    @State var address: String = ""
    
    var body: some View {
        VStack {
            TextField("name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("address", text: $address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Button("Add") {
                    // dateAdded 매개변수 생략
                    restaurantStore.addRestaurant(restaurant:
                                                    Restaurant(name: name, address: address)
                    )
                }
                Button("Update") {
                    restaurantStore.updateRestaurant(restaurantName: name, restaurantAddress: address)
                }
                Button("Delete") {
                    restaurantStore.deleteRestaurant(restaurantName: name)
                }
            }
            
            Button("Load") { restaurantStore.fetchAllRestaurant() }
                
            
            Spacer()
            List {
                ForEach(restaurantStore.restaurants, id: \.self) { rest in
                    HStack {
                        Text(rest.name)
                        Spacer()
                        Text(rest.address)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        restaurantStore.deleteRestaurant(restaurantName: restaurantStore.restaurants[index].name)
                    }
                    self.mode.wrappedValue.dismiss()
                })
            }
        }
        .padding()
        .onAppear {
            self.restaurantStore.startListening()
        }
        .onDisappear {
            self.restaurantStore.stopListening()
        }
        
    }
}

//#Preview {
//    FireStoreView()
//}
