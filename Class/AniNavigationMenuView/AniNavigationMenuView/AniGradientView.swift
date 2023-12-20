//
//  AniGradientView.swift
//  AniNavigationMenuView
//
//  Created by 이민영 on 2023/12/20.
//

import SwiftUI

struct AniGradientView: View {
    var body: some View {
//       StartEndAniGradientView()
        RadialAniGradientView()
    }
}

struct StartEndAniGradientView: View {
    
    // 애니메이션 상태를 유지하는 상태 변수를 선언
    @State private var animateGradient = false
    
    var body: some View {
        LinearGradient(colors: [.purple, .yellow], 
                       startPoint: animateGradient ? .topLeading : .bottomLeading,
                       endPoint: animateGradient ? .bottomTrailing : .topTrailing)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 2).repeatForever(autoreverses: true)){
                    animateGradient.toggle()
                }
            }
    }
    
}


struct RadialAniGradientView: View {
    
    // 애니메이션 상태를 유지하는 상태 변수를 선언
    @State private var animateGradient = false
    
    var body: some View {
        RadialGradient(colors: [.purple, .yellow],
                       center: .topLeading,
                       startRadius: animateGradient ? 400 : 200,
                       endRadius: animateGradient ? 20 : 40)
            .ignoresSafeArea()

            .onAppear {
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)){
                    animateGradient.toggle()
                }
            }
    }
    
}

// 색초 회전을 사용하여 그라데이션에 애니메이션
//struct RadialAniGradientView: View {
//    
//    // 애니메이션 상태를 유지하는 상태 변수를 선언
//    @State private var animateGradient = false
//    
//    var body: some View {
//        RadialGradient(colors: [.purple, .yellow],
//                       center: .topLeading,
//                       startRadius: animateGradient ? 400 : 200,
//                       endRadius: animateGradient ? 20 : 40)
//            .ignoresSafeArea()
//
//            .onAppear {
//                withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)){
//                    animateGradient.toggle()
//                }
//            }
//    }
//    
//}


#Preview {
    AniGradientView()
}


