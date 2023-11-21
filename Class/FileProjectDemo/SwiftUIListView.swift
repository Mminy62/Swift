//
//  SwiftUIListView.swift
//  FileProjectDemo
//
//  Created by 이민영 on 2023/11/20.
//

import SwiftUI

struct SwiftUIListView: View {
    
    var items:[String] = []
    
    var body: some View {
        VStack{
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
        }
        
       
    }
}

