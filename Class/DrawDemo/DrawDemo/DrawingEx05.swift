//
//  DrawingEx05.swift
//  DrawDemo
//
//  Created by 이민영 on 2023/12/19.
//

import SwiftUI

struct DrawingEx05: View {
    var body: some View {
        DShape()
            .frame(width: 300, height: 300)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
    }
}


struct DShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX + 25, y: rect.midY + 25)
        path.move(to: center)
        return path
    }
}

struct ColorCircle: Shape {
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
    DrawingEx05()
}
