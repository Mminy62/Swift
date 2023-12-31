//
//  CoreDataDemo3App.swift
//  CoreDataDemo3
//
//  Created by 이민영 on 2023/12/31.
//

import SwiftUI

@main
struct CoreDataDemo3App: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
            
            
        }
    }
}
