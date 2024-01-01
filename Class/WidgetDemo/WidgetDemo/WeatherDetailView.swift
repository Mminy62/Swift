//
//  WeatherDetailView.swift
//  WidgetDemo
//
//  Created by 이민영 on 2023/12/28.
//

import SwiftUI

struct WeatherType: Hashable {
    var name: String
    var icon: String
}

struct WeatherDetailView: View {

    var weather: WeatherType
    
    var body: some View {
        VStack {
            Image(systemName: weather.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            Text(weather.name)
                .padding()
                .font(.title)

            Text("If this were a real weather app, a description of \(weather.name) would appear here.")
                .padding()
            Spacer()
        }
    }
}

//#Preview {
//    WeatherDetailView()
//}
