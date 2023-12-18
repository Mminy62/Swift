//
//  ContentView.swift
//  UITestingDemo
//
//  Created by 이민영 on 2023/12/18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showLogin = false
    @EnvironmentObject private var user: User
    
    var body: some View {
        VStack {
            Text(!user.isLoggedin ? "Welcome!" : "Welcome \(user.username)!")
                .font(.title)
            
            Spacer().frame(height: 20)
            
            Button {
                if !user.isLoggedin {
                    showLogin = true
                } else {
                    user.logout()
                }
                
            } label: {
                Text(!user.isLoggedin ? "Login" : "Logout")
            }
            // 식별자 추가
            .accessibilityIdentifier("loginButton")
        }
        .padding()
        .sheet(isPresented: $showLogin) {// sheet는 vstack에 넣고 사용
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
