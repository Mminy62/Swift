//
//  lazyVGridExample.swift
//  UIKitPlayground
//
//  Created by 이민영 on 2023/11/24.
//

import Foundation
import SwiftUI

struct LazyGridExampleView: View {

    let gridLayoutSetting: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                LazyVGrid(columns: gridLayoutSetting) {
                    ForEach(0...15, id: \.self) { _ in
                        Rectangle()
                            .foregroundStyle(Color.gray)
                            .frame(height: geometry.size.width / 3 - 10)
                    }
                }
            }
        }
        .padding()
    }
}

