//
//  AuthView.swift
//  FirebaseDemo
//
//  Created by 이민영 on 2024/01/09.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @ObservedObject var authManager = AuthManager.shared
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if authManager.state == .signedOut {
                    
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                    Button("Sign in") {
                        authManager.emailAuthSignIn(email: email, password: password)
                    }
                    NavigationLink {
                        AuthSignUpView()
                    } label: {
                        Text("가입")
                    }
                    
                } else {
                    HStack {
                        Button("Sign out") {
                            authManager.signOut()
                        }
                        Button("탈퇴") {
                            authManager.deleteUser()
                        }
                    }
                    
                    StorageView()
                }
            }
            .padding()
            .onAppear {
                authManager.checkSignIn()
            }
        }
    }
}
#Preview {
    AuthView()
}
