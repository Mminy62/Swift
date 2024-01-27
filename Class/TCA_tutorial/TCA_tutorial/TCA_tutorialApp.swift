//
//  TCA_tutorialApp.swift
//  TCA_tutorial
//
//  Created by 이민영 on 2024/01/12.
//
import ComposableArchitecture
import SwiftUI

@main
struct TCA_tutorialApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
          CounterView(store: TCA_tutorialApp.store)
        }
      }
}
