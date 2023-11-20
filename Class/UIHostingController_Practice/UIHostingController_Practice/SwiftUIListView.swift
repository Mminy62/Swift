//
//  TableView.swift
//  UIHostingController_Practice
//
//  Created by 이민영 on 2023/11/20.
//

import SwiftUI

struct Family: Identifiable {
  var id = UUID()
  var name: String
}

struct FamilyRow: View {
  var family: Family
  
  var body: some View {
    Text("Family: \(family.name)")
  }
}

struct SwiftUIListView: View {
    
    let first = Family(name: "Hohyeon")
    let second = Family(name: "Moon")
    let third = Family(name: "Jigom")
    
    var body: some View {
      let families = [first, second, third]
      
      return List(families) { family in
        FamilyRow(family: family)
      }
    }
}

//#Preview {
//    TableView()
//}
