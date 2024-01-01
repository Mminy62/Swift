//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by 이민영 on 2023/12/28.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetLiveActivity()
    }
}
