//
//  ExGestureView.swift
//  GestureDemo
//
//  Created by 이민영 on 2023/12/21.
//

import SwiftUI

struct ExGestureView: View {
    var body: some View {
        //        AniLongPressGestureView()
        AniDragGestureView()
    }
}

//LongPressed action
struct  AniLongPressGestureView: View {
    
    @GestureState private var longPressTap = false
    @State private var isPressed = false
    
    var body: some View {
        Image(systemName: "staroflife.circle")
            .font(.system(size: 200))
            .foregroundColor(.mint)
            .scaleEffect(isPressed ? 0.5 : 1.0)
            .animation(.easeInOut, value: longPressTap)
            .gesture(
                LongPressGesture(minimumDuration: 1.0)
                    .updating($longPressTap) { curState, gestureState, transaction in
                        gestureState = curState
                        //                        transaction.animation = Animation.easeIn(duration: 1.0)
                        
                    }
                    .onEnded{ _ in self.isPressed.toggle()}
            )
    }
}

// 드래그 동작 사용
// 이미지를 드래그하여 이동하도록
// 프로젝트를 실행하고 이미지를 드래그하면 드래그가 끝난 후에도 이미지가 그대로 유지
struct AniDragGestureView: View {
    
    @State private var offset: CGSize = .zero
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: "arrow.right.circle.fill")
                .font(.system(size: 50))
                .offset(x: offset.width + dragOffset.width, y: offset.height + dragOffset.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.dragOffset = value.translation
                        }
                        .onEnded { value in
                            withAnimation {
                                let maxX = geometry.size.width - 50 // 뷰의 폭
                                let newX = self.offset.width - value.translation.width
                                self.offset.width = min(maxX, max(0, newX))
                                self.dragOffset = .zero
                            }
                        }
                )
        }
    }
    
}

#Preview {
    ExGestureView()
}
