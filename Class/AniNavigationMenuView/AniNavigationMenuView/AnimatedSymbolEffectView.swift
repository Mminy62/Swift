//
//  AnimatedSymbolEffectView.swift
//  AniNavigationMenuView
//
//  Created by 이민영 on 2023/12/20.
//

import SwiftUI

struct AnimatedSymbolEffectView: View {
    var body: some View {
        VStack {
//            BounceAniSFView()
//            MoreSymbolAnimationView()
            ContentTrasitionAnimationView()
        }
    }
}

// 콘텐츠 전환 및 애니메이션 교체
struct ContentTrasitionAnimationView: View {
    
    @State private var animate = false
    
    var body: some View {
        Image(systemName: animate ? "checkmark.circle" : "touchid")
            .font(.system(size: 100))
            .symbolRenderingMode(.palette)
            .foregroundStyle(.purple, .gray)
            // options: repeat(특정 횟수 만큼 반복), speed(애니메이션 속도 제어)
            .symbolEffect(.bounce, options: .speed(1.5), value: animate)
            .contentTransition(.symbolEffect(.replace))
            .onTapGesture {
                animate.toggle()
            }
    }
}

// SymbolEffect 수정자를 여러개 사용하여 다양한 애니메이션을 표현
struct MoreSymbolAnimationView: View {
    
    @State private var animate = false
    
    var body: some View {
        Image(systemName: "ellipsis.message")
            .font(.system(size: 100))
            .symbolRenderingMode(.palette)
            .foregroundStyle(.purple, .gray)
            // options: repeat(특정 횟수 만큼 반복), speed(애니메이션 속도 제어)
            .symbolEffect(.bounce, options: .speed(1.5), value: animate)
            .symbolEffect(.pulse, options: .repeating, value: animate)
            .onTapGesture {
                animate.toggle()
            }
    }
}

// .symbolEffect() 수정자의 .bounce 애니메이션을 사용
struct BounceAniSFView: View {
    
    @State private var animate = false
    
    var body: some View {
        Image(systemName: "ellipsis.message")
            .font(.system(size: 100))
            .symbolRenderingMode(.palette)
            .foregroundStyle(.purple, .gray)
            // options: repeat(특정 횟수 만큼 반복), speed(애니메이션 속도 제어)
            .symbolEffect(.bounce, options: .repeat(2).speed(1.5), value: animate)
            .onTapGesture {
                animate.toggle()
            }
    }
}

#Preview {
    AnimatedSymbolEffectView()
}
