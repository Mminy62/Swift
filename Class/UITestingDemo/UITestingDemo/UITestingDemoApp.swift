//
//  UITestingDemoApp.swift
//  UITestingDemo
//
//  Created by 이민영 on 2023/12/18.
//

import SwiftUI

@main
struct UITestingDemoApp: App {
    var user = User()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
        }
    }
}
