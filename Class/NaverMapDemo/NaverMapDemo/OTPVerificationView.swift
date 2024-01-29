//
//  modalView.swift
//  NaverMapDemo
//
//  Created by 이민영 on 2024/01/29.
//

import SwiftUI
import FirebaseAuth

struct OTPVerificationView: View {
    @State var verificationID: String = ""
    var mobileNumber: String = ""
    
    @State private var otp: String = ""
    
    var body: some View {
        VStack{
            Text("Welcome to OTP Verification Process\(mobileNumber)")
            
            TextField("", text: $otp)
                .placeholder(when: otp.isEmpty) {
                    Text("Enter OTP")
                        .foregroundStyle(.secondary)
                    
                }
                .keyboardType(.numberPad)
                .padding(10)
                .frame(minWidth: 80, minHeight: 47)
                .background(Color(.systemGray5), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            Button {
                self.verifyOTP()
            } label: {
                Text("Verify")
            }
            .disableWithOpacity(otp.count < 6)
            .buttonStyle(.plain)
            Spacer()
        }
    }
    
    private func verifyOTP() {
        // 인증 코드, 인증 ID를 사용해 FIRPhoneAuthCredential 객체 생성
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otp)
        
        // credential 객체로 signin(로그인)
        Auth.auth().signIn(with: credential) { user, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("OTP Verify Success = \(user?.user.uid ?? "N/A")")
            }
            
        }
    }
    
    func resendOTP() {
        print(mobileNumber)
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(mobileNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let verificationID = verificationID {
                    self.verificationID =  verificationID
                    print("Code has been resent!")
                    // 왜 @State를 붙이면 에러가 사라지는 건지?
                }
            }
    }
}

#Preview {
    OTPVerificationView()
}
