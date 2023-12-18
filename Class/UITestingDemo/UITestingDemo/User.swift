//
//  User.swift
//  UITestingDemo
//
//  Created by 이민영 on 2023/12/18.
//

import Foundation

class User: ObservableObject {
    @Published var isLoggedin = false
    @Published var username = ""
    @Published var password = ""
    
    func login() -> Bool {
        guard username == "test" && password == "pass" else {
            return false
        }
        
        password = ""
        isLoggedin = true
        
        return true
    }
    
    func logout() {
        isLoggedin = false
        username = ""
    }
}
