//
//  ContentView.swift
//  UITestingDemo
//
//  Created by 이민영 on 2023/12/18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showLogin = false
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.title)
            
            Button {
                showLogin = true
            } label: {
                Text("Login!")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
