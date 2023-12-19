//
//  ContentView.swift
//  DrawDemo
//
//  Created by 이민영 on 2023/12/19.
//

import SwiftUI

struct ContentView: View {
    
    let badge = Badge()
    
    var body: some View {
        VStack {
            badge
            PathView()
            MyShape()

            
//            Ellipse()
//                .stroke(style: StrokeStyle(lineWidth: 20, dash: [CGFloat(10), CGFloat(5), CGFloat(2)]))
        }
        .padding()
    }
}

struct MyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                          control: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}

struct PathView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 10, y:10))
            path.addLine(to: CGPoint(x: 10, y:350))
            path.addLine(to: CGPoint(x: 300, y:300))
            
        }
    }
}


#Preview {
    ContentView()
}
