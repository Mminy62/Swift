//
//  ContentView.swift
//  FirebaseDemo
//
//  Created by 박준영 on 1/4/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var productStore = ProductStore.shared
    @State var name: String = ""
    @State var description: String = ""
    @State var isOrder: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    productStore.addProduct(item:
                                                Product(
                                                    id: UUID().uuidString,
                                                    name: name, description: description, isOrder: isOrder))
                } label: {
                    Text("Add Product")
                }
                
                Spacer()
                List {
                    ForEach(productStore.products, id: \.self) { product in
                        Text(product.name)
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            productStore.deleteProduct(key: productStore.products[index].id )
                        }
                        self.mode.wrappedValue.dismiss()
                    })
                }
                
            }
            .padding()
            .onAppear {
                self.productStore.startListening()
            }
            .onDisappear {
                self.productStore.stopListening()
            }
        } // NavigationStack
    }
}

//#Preview {
//    ContentView()
//}
