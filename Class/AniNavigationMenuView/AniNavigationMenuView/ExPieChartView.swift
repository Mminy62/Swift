//
//  ExPieChartView.swift
//  AniNavigationMenuView
//
//  Created by 이민영 on 2023/12/20.
//

import SwiftUI

struct ExPieChartView: View {
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 187, y: 187))
                path.addArc(center: CGPoint(x: 187, y: 187), radius: 150,
                            startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 190.0), clockwise: true)
            }
            .fill(.yellow)
            
            Path { path in
                path.move(to: CGPoint(x: 187, y: 187))
                path.addArc(center: CGPoint(x: 187, y: 187), radius: 150,
                            startAngle: Angle(degrees: 190.0), endAngle: Angle(degrees: 110), clockwise: true)
            }
            .fill(.teal)
            
            Path { path in
                path.move(to: CGPoint(x: 187, y: 187))
                path.addArc(center: CGPoint(x: 187, y: 187), radius: 150,
                            startAngle: Angle(degrees: 110), endAngle: Angle(degrees: 90), clockwise: true)
            }
            .fill(.blue)
            
            Path { path in
                path.move(to: CGPoint(x: 187, y: 187))
                path.addArc(center: CGPoint(x: 187, y: 187), radius: 150,
                            startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0), clockwise: true)
            }
            .fill(.purple)
            .offset(x: 20, y: 20)
            
            Path { path in
                path.move(to: CGPoint(x: 187, y: 187))
                path.addArc(center: CGPoint(x: 187, y: 187), radius: 150,
                            startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0), clockwise: true)
                path.closeSubpath()
            }
            .stroke(.black, lineWidth: 10)
            .offset(x: 20, y: 20)
            .overlay {
                Text("25%")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                    .offset(x: 80, y: -100)
            }
        }
    }
}

#Preview {
    ExPieChartView()
}
