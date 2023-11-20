//
//  SwiftUIView.swift
//  UIHostingController
//
//  Created by 이민영 on 2023/11/20.
//

import SwiftUI

struct SwiftUIView: View {
    
    var text: String
    
    var body: some View {
        VStack{
            Text(text)
            HStack{
                Image(systemName: "smiley")
                Text("This is a SwiftUI View")
            }
        }
        .font(.largeTitle)
    }
}

//#Preview {
//    SwiftUIView()
//}
