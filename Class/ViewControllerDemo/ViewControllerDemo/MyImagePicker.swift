//
//  MyImagePicker.swift
//  ViewControllerDemo
//
//  Created by 이민영 on 2023/11/24.
//

import SwiftUI

struct MyImagePicker: UIViewControllerRepresentable {
 
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MyImagePicker>) -> some UIViewController {
        let picker = UIImagePickerController() // 화면 하나 만들고
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    
    
}

