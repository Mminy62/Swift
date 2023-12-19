//
//  SwiftUIView.swift
//  DrawDemo
//
//  Created by 이민영 on 2023/12/19.
//

import SwiftUI

struct Ex01: View{
    var body: some View {
        DrawingEx01()
            .stroke(.black, lineWidth: 10)
            .fill(.purple)
            .frame(width: 200, height: 70)
    }
}

struct DrawingEx01: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.maxX/10, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX/10, y: rect.midY),
            control: CGPoint(x: rect.midX, y: rect.minY - 20))
        path.addLine(to: CGPoint(x: rect.maxX/10, y: rect.midY))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    Ex01()
}


