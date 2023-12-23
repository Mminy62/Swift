//
//  KeyframeAnimatorView.swift
//  AniNavigationMenuView
//
//  Created by 이민영 on 2023/12/20.
//

import SwiftUI

struct KeyframeAnimatorView: View {
    var body: some View {
        EmojiKeyframeAnimatorView()
    }
}

// 애니메이션의 값 정의
struct AnimationValues {
    var scale = 1.0
    var varticalStretch = 1.0
    var translation = CGSize.zero
    var opactiy = 1.0
}

// KeyframeAnimator
struct EmojiKeyframeAnimatorView: View {
    
    // repeating 매개변수에 원하는 조건을 지정하여 시작 기준을 정의
    @State private var startAnimation = false
    
    var body: some View {
        VStack {
            Text("😹")
                .font(.system(size: 100))
                .keyframeAnimator(initialValue: AnimationValues(), repeating: startAnimation) { content, value in
                    content
                        .scaleEffect(value.scale)
                        .scaleEffect(y: value.varticalStretch)
                        .offset(value.translation)
                        .opacity(value.opactiy)
                } keyframes: { Value in
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(0.8, duration: 0.2)
                        // 시간이 지남에 따라 다른 값 변경을 자유롭게 정의
                        //  애니메이션이 더 부드럽고 유동적으로 변한 것을 확인
                        CubicKeyframe(0.6, duration: 0.3)
                        CubicKeyframe(1.0, duration: 0.3)
                        
                        CubicKeyframe(0.8, duration: 0.2)
                        CubicKeyframe(0.5, duration: 0.3)
                        CubicKeyframe(1.0, duration: 0.3)
                    }
                    
                    KeyframeTrack(\.varticalStretch) {
                        LinearKeyframe(1.2, duration: 0.1)
                        SpringKeyframe(2.0, duration: 0.2, spring: .snappy)
                        CubicKeyframe(1.05, duration: 0.3)
                        CubicKeyframe(1.2, duration: 0.2)
                        CubicKeyframe(1.1, duration: 0.32)
                        CubicKeyframe(1.2, duration: 0.2)
                        CubicKeyframe(1.05, duration: 0.25)
                        CubicKeyframe(1.3, duration: 0.23)
                        CubicKeyframe(1.0, duration: 0.3)
                    }
                    
                    KeyframeTrack(\.translation) {
                        SpringKeyframe(CGSize(width: 100, height: 100), duration: 0.4)
                        SpringKeyframe(CGSize(width: -50, height: -300), duration: 0.4)
                        SpringKeyframe(.zero, duration: 0.2)
                        SpringKeyframe(CGSize(width: -50, height: 200), duration: 0.3)
                        SpringKeyframe(CGSize(width: -90, height: 300), duration: 0.3)
                        SpringKeyframe(.zero, duration: 0.4)
                    }
                    
                    KeyframeTrack(\.opactiy) {
                        LinearKeyframe(0.5, duration: 0.2)
                        LinearKeyframe(1.0, duration: 0.23)
                        LinearKeyframe(0.7, duration: 0.25)
                        LinearKeyframe(1.0, duration: 0.33)
                        LinearKeyframe(0.8, duration: 0.2)
                        LinearKeyframe(1.0, duration: 0.23)
                    }
                }
                .onTapGesture {
                    startAnimation.toggle()
                }
        }
    }
}

#Preview {
    KeyframeAnimatorView()
}
