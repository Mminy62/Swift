//
//  AuthView.swift
//  FirebaseDemo
//
//  Created by 이민영 on 2024/01/09.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button("Sign in") {
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    if let user = result?.user {
                        print("Success, \(user.uid)")
                    }
                    
                }
            }
            
            Button("Sign out") {
                try? Auth.auth().signOut()
            }
            Button("탈퇴") {
                if let user = Auth.auth().currentUser {
                    user.delete { error in
                        if let error = error {
                            print("Error deleting user", error)
                        } else {
                            print("탈퇴 완료", user)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            if Auth.auth().currentUser != nil {
                print("로그인 중...")
            } else {
                print("로그인 필요")
            }
            
        }
        
    }
}

#Preview {
    AuthView()
}
