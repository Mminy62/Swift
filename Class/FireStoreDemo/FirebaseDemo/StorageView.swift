//
//  StorageView.swift
//  FirebaseDemo
//
//  Created by 이민영 on 2024/01/08.
//

import SwiftUI

struct StorageView: View {
    
    @ObservedObject var storageManager = StorageManager.shared
    @State var image = UIImage()
    @State var showSheet = false
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("Change photo")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .onTapGesture {
                        showSheet = true
                    }
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: $showSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
            }
            .onChange(of: image) {
                storageManager.upload(image: image)
            }
            
            Button("Load") {
                storageManager.listAllFiles()
            }
            
            Spacer()
            List {
                ForEach(storageManager.images, id: \.self) { simage in
                    HStack {
                        Image(uiImage: simage.image)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .aspectRatio(contentMode: .fill)
                            .background(.black.opacity(0.2))
                            .clipShape(Circle())
                        Text(simage.name)
                        Text(simage.fullPath)
                    }
                }
            }
        }
    }
}

#Preview {
    StorageView()
}
