//
//  AniContentView.swift
//  DrawDemo
//
//  Created by 이민영 on 2023/12/19.
//
import SwiftUI

struct AniContentView: View {
        var body: some View {
        VStack {
            ButtonImplicitAniView()
            ButtonExplicitAniView()
            CircleExplicitAniView()
            StateBindingAniView()
        }

    }
}

// 애니메이션과 상태 바인딩
struct StateBindingAniView: View {
    
    @State private var visibility = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $visibility.animation(.linear(duration: 1))) {
                Text("Toggle Text Views")
            }
            .padding()
            
            if visibility {
                Text("Hello World")
                    .font(.largeTitle)
            }
            
            if !visibility {
                Text("Goodbye World")
                    .font(.largeTitle)
            }
        }
        
    }
}

// 명시적 애니메이션
struct CircleExplicitAniView: View {
    
    @State private var yellowCircle = false
    
    var body: some View {
        Circle()
            .fill(yellowCircle ? .yellow : .blue)
            .frame(width: 100, height: 100)
            .onTapGesture {
                withAnimation {
                    yellowCircle.toggle()
                }
            }

    }
}

// 명시적 애니메이션
struct ButtonExplicitAniView: View {
    
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Button {
            withAnimation(.linear(duration: 2)) {
                // 회전 애니메이션만 적용
                self.rotation = (self.rotation < 360 ? self.rotation + 60 : 0)
            }
            self.scale = (self.scale < 2.8 ? self.scale + 0.3 : 1)
        } label: {
            Text("Click to animate")
                .rotationEffect(.degrees(rotation))
                .scaleEffect(scale)
        }

    }
}


// 암묵적 애니메이션
struct ButtonImplicitAniView: View {
    
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Button {
            self.rotation = (self.rotation < 360 ? self.rotation + 60 : 0)
            self.scale = (self.scale < 2.8 ? self.scale + 0.3 : 1)
        } label: {
            Text("Click to animate")
                .rotationEffect(.degrees(rotation))
            // repeatCount() 수정자 : 지정된 횟수만큼 애니메이션을 반복
//                .animation(.linear(duration: 1).repeatCount(2, autoreverses: true), value: rotation)
            // repeatForever() 수정자 : 애니메이션을 무한 반복
//                .animation(.linear(duration: 1).repeatForever(autoreverses: true), value: rotation)
                .animation(.spring(response: 1, dampingFraction: 0.2, blendDuration: 0), value: rotation)
                .scaleEffect(scale)
        }

    }
}

#Preview {
    AniContentView()
}
