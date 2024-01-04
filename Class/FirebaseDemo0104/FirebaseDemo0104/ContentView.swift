//
//  ContentView.swift
//  FirebaseDemo0104
//
//  Created by 이민영 on 2024/01/04.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var productStore = ProductStore.shared
    @State var name: String = ""
    @State var description: String = ""
    @State var isOrder: Bool = false
    
    var body: some View {
        VStack {
            TextField("name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                productStore.addProduct(item:
                                            Product(
                                                id: UUID().uuidString,
                                                name: name,
                                                description: description,
                                                isOrder: isOrder
                                            )
                )
            } label: {
                Text("Add Product")
            }
            
            Spacer()
            List {
                ForEach(productStore.products, id: \.self) { product in
                    Text(product.name)
                }
            }
            
        }
        .padding()
        .onAppear {
            self.productStore.listenToRTDatabase()
        }
        .onDisappear {
            self.productStore.stopListening()
        }
    }
}

#Preview {
    ContentView()
}
