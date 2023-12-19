//
//  DrawingEx02.swift
//  DrawDemo
//
//  Created by 이민영 on 2023/12/19.
//

import SwiftUI

struct DrawingEx02: View {
    var body: some View {
        ZStack{
            PieSegment(start: .zero, end: .degrees(190))
                .fill(.yellow)
            PieSegment(start: .degrees(190), end: .degrees(110))
                .fill(.mint)
            PieSegment(start: .degrees(110), end: .degrees(90))
                .fill(.cyan)
            
            PieSegment2(start: .degrees(90), end: .degrees(0))
                .stroke(Color.indigo, lineWidth: 20)
                .fill(.purple)
            
            Text("25%")
                .position(CGPoint(x: 240, y: 250))
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
            
        }
        .frame(width: 300, height: 300)
       
        
    }
}



struct PieSegment: Shape {
    var start: Angle
    var end: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center, radius: rect.midX, startAngle: start, endAngle: end, clockwise: true)
        
        return path
    }
}

struct PieSegment2: Shape {
    var start: Angle
    var end: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX + 25, y: rect.midY + 25)
        path.move(to: center)
        path.addArc(center: center, radius: rect.midX, startAngle: start, endAngle: end, clockwise: true)

        path.addLine(to: CGPoint(x: rect.midX + 15, y: rect.midY + 25))
        return path
    }
}



#Preview {
    DrawingEx02()
}
