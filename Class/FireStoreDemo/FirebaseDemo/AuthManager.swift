//
//  AuthManager.swift
//  FirebaseDemo
//
//  Created by 이민영 on 2024/01/09.
//

import Foundation
import FirebaseAuth

enum SignInState {
    case signedIn, signedOut
}

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    private init() {}
    // 로그인, 로그아웃 하는 상태를 보관하는 법
    @Published var state: SignInState = .signedOut
    
    func emailAuthSignUp(userName: String, email: String, password: String) {
           Auth.auth().createUser(withEmail: email, password: password) { result, error in
               guard error == nil else {
                   print(error!)
                   return
               }

               if let user = result?.user {
                   let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                   changeRequest?.displayName = userName
                   print("user email: \(String(describing: user.email))")
                   print("user 이름: \(String(describing: user.displayName))")
               }
           }
       }
    
    func emailAuthSignIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error!)
                return
            }
            if let user = result?.user {
                print("Success, \(user.uid)")
                self.state = .signedIn
            }
            
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return
        }
        self.state = .signedOut
        print("로그아웃 성공")
        
    }
    
    func checkSignIn() {
        if Auth.auth().currentUser != nil {
            self.state = .signedIn
        }
    }
    
    func deleteUser() {
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    print("Error deleting user", error)
                } else {
                    self.state = .signedOut
                }
            }
        }
    }
    
}
