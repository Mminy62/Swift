//
//  ContentView.swift
//  UIViewDemo
//
//  Created by 이민영 on 2023/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            MyScrollView(text: "UIView in SwiftUI")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
