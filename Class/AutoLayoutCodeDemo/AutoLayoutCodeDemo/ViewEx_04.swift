//
//  ViewEx_04.swift
//  AutoLayoutCodeDemo
//
//  Created by 이민영 on 2023/11/13.
//

import Foundation
import UIKit

class ViewEx_04: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createLayout()
    }
    
    func createLayout(){
        let superview = self.view
        
        let Button = UIButton()
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.configuration = .tinted()
        Button.setTitle("Tab Me", for: .normal)
        
        superview?.addSubview(Button)
        
        Button.leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: 20).isActive = true
        Button.trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -20).isActive = true
        Button.bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -50).isActive = true
        
        
        
        
    }
}
