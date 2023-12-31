//
//  Persistence.swift
//  CoreDataDemo3
//
//  Created by 이민영 on 2023/12/31.
//

import CoreData
import Foundation

// MARK: - 맨 위에서 직접 통신하는 PersistentContainer생성
struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Products")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
    }
    
}
