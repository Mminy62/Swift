//
//  ContentView.swift
//  WidgetDemo
//
//  Created by 이민영 on 2023/12/28.
//

import SwiftUI

struct ContentView: View {
//    var body: some View {
//        VStack {
//            NavigationStack {
//                List {
//                    NavigationLink(value: "dfsad")
//                }
//            }
//        }
//        .padding()
//        
//    }
    var body: some View {
           VStack {
               Image(systemName: "globe")
                   .imageScale(.large)
                   .foregroundStyle(.tint)
               Text("Hello, world!")
           }
           .padding()
       }
    
}

#Preview {
    ContentView()
}
