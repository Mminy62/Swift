//
//  Models.swift
//  UIHostingController_Practice
//
//  Created by 이민영 on 2023/11/20.
//

import Foundation
import SwiftUI

struct Item: Identifiable{
    let id = UUID()
    let url: URL
}

extension Item: Equatable{
    static func == (lhs: Item, rhs, Item) -> Bool{
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
