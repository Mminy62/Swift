//
//  QueryView.swift
//  FirebaseDemo
//
//  Created by 이민영 on 2024/01/08.
//

import SwiftUI

struct QueryView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var cityStore = CityStore.shared
    @State var name: String = ""
    @State var state: String = ""
    @State var country: String = ""
    @State var capital: Bool = false
    @State var population: String = ""
    @State var regions: String = ""
    
    var body: some View {
        VStack {
            TextField("name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("state", text: $state)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("country", text: $state)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Toggle("capital", isOn: $capital)
            
            TextField("population", text: $population)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("regions", text: $regions)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Button("Add") {
                    // dateAdded 매개변수 생략
                    cityStore.addCity(city: City(name: name, state: state, country: country, capital: capital, population: population.toInt(), regions: regions.split(separator: ",").map(String.init))
                    )
                }
                Button("Update") {
                    cityStore.updateCity(cityName: name, cityAddress: state)
                }
                Button("Delete") {
                    cityStore.DeleteCity(cityName: name)
                }
            }
            
            Button("Load") { cityStore.fetchAllRestaurant() }
            
            Button("Query") { cityStore.simpleQueries() }
            
            Spacer()
            List {
                ForEach(cityStore.cities, id: \.self) { rest in
                    HStack {
                        Text(rest.name)
                        Spacer()
                        Text(rest.state)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        cityStore.DeleteCity(cityName: cityStore.cities[index].name)
                    }
                    self.mode.wrappedValue.dismiss()
                })
            }
        }
        .padding()
        .onAppear {
            self.cityStore.startListening()
        }
        .onDisappear {
            self.cityStore.stopListening()
        }
        
    }
}

//#Preview {
//    QueryView()
//}
