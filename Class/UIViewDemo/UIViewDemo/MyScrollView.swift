//
//  MyScrollView.swift
//  UIViewDemo
//
//  Created by 이민영 on 2023/11/24.
//

import SwiftUI

struct MyScrollView: UIViewRepresentable {
  
    
    
    var text: String
    
    func makeUIView(context: UIViewRepresentableContext<MyScrollView>) -> some UIView {
        let scrollView = UIScrollView()
        scrollView.refreshControl = UIRefreshControl()
        
        let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        myLabel.text = text
        scrollView.addSubview(myLabel)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
//    
    
}

