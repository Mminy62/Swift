//
//  ContentView.swift
//  ViewControllerDemo
//
//  Created by 이민영 on 2023/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var imagePickerVisible: Bool = false
    @State var selectedImage: Image? = Image(systemName: "photo")
    
    var body: some View {
        VStack {
            selectedImage?
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button("Select an Image"){
                imagePickerVisible.toggle()
            }
        }
        .padding()
        
        
        if imagePickerVisible {
            MyImagePicker()
        }
        
        
        
    }
}
//
//#Preview {
//    ContentView()
//}
