//
//  LoginView.swift
//  NaverMapDemo
//
//  Created by 이민영 on 2024/01/29.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @State var phoneNumber: String = ""
    
    var body: some View {
        VStack {
            Text("EYE-Mate")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color.customGreen)
            
            VStack(alignment: .leading, spacing: 3){
                Text("전화번호")
                TextField("", text: $phoneNumber)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10.0)
                        .frame(width: 300, height: 50)
                        .foregroundStyle(Color(hex: "F6F6F6")))
                    .frame(width: 300, height: 50)
                    .keyboardType(.numberPad)
                    
            }
            .padding()
            
            Button {
                loginViewModel.login()
            } label: {
                
                Text("인증번호 요청")
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 20.0)
                        .foregroundStyle(Color.customGreen)
                        .opacity(0.8)
                        .frame(width: 100, height: 25))
                
                
            }
            
        }
        
        
    }
}

#Preview {
    LoginView()
}
