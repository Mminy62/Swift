//
//  IndicationButtonExample.swift
//  UIKitPlayground
//
//  Created by 이민영 on 2023/11/24.
//

import SwiftUI

struct IndicationButtonExample: View {
    
    @State private var isProgressIndicatorShowing: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                isProgressIndicatorShowing.toggle()
            }, label: {
                HStack {
                    if isProgressIndicatorShowing {
                        ProgressView()
                            .padding(.trailing, 3)
                    } else {
                        Image(systemName: "square.and.arrow.up")
                    }
                    Text("ExampleButton")
                }
                
            })
            .buttonStyle(.borderedProminent)
        }
    }
}
#Preview {
    IndicationButtonExample()
}
