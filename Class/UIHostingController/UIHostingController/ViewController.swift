//
//  ViewController.swift
//  UIHostingController
//
//  Created by 이민영 on 2023/11/20.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 코드로 추가하는 방법
        // Let으로 선언한 거니까 func안에 선언해야한다
        let swiftUIController = UIHostingController(rootView: SwiftUIView(text: "Integration Three"))
        addChild(swiftUIController)
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(swiftUIController.view)
        
        swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }
    
    

    
    
    // hos
    @IBSegueAction func showSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(text: "Integration One"))
        
    }
    
    @IBSegueAction func embedSwiftUI(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(text:
    "Container View"))
    }
    
}

