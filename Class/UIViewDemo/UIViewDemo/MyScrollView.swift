//
//  MyScrollView.swift
//  UIViewDemo
//
//  Created by 이민영 on 2023/11/24.
//

import SwiftUI

// UIScrollview 랩핑
struct MyScrollView: UIViewRepresentable {
    
    var text: String
    
    func makeUIView(context: UIViewRepresentableContext<MyScrollView>) -> some UIView {
        let scrollView = UIScrollView()
        // 코디네이터를 델리게이트로 추가
        scrollView.delegate = context.coordinator
        
        scrollView.refreshControl = UIRefreshControl()
        //리프레시 컨트롤에 대한 타깃으로 handleRefresh 추가
        scrollView.refreshControl?.addTarget(context.coordinator,
                                             action: #selector(Coordinator.handleRefresh),
                                             for: UIControl.Event.valueChanged)
        
        let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        myLabel.text = text
        scrollView.addSubview(myLabel)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    // 코디네이터 구현 : 이벤트에 대한 반응이 필요한 뷰일 경우
    class Coordinator: NSObject, UIScrollViewDelegate {
        var control: MyScrollView
        
        init(_ control: MyScrollView) {
            self.control = control
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            print("View is scrolling")
        }
        
        @objc func handleRefresh(sender: UIRefreshControl){
            sender.endRefreshing()
        }
        
    }
//
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
}

