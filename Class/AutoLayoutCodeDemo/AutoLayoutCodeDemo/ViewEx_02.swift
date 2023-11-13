//
//  ViewEx_02.swift
//  AutoLayoutCodeDemo
//
//  Created by 이민영 on 2023/11/13.
//

import Foundation
import UIKit

class ViewEx_02: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createLayout()
    }
    
    func createLayout(){
        let superView = self.view
        
        let myLabel = UILabel()
        // 코드가 아닌 기본 layout 설정과 겹칠때를 대비하여, 기본 속성 꺼주기
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "Hello"
        
        
        let myLabel2 = UILabel()
        myLabel2.translatesAutoresizingMaskIntoConstraints = false
        myLabel2.text = "World"
     
        
        superView?.addSubview(myLabel)
        superView?.addSubview(myLabel2)
        
        var Constraint =
        NSLayoutConstraint(
            item: myLabel,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superView,
            attribute: NSLayoutConstraint.Attribute.centerX,
            multiplier: 1.0,
            constant: 0
        )
        
        superView?.addConstraint(Constraint)
        
        Constraint = NSLayoutConstraint(
            item: myLabel,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superView,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1.0,
            constant: 100
        )
        
        superView?.addConstraint(Constraint)
        
        Constraint = NSLayoutConstraint(
            item: myLabel2,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: myLabel,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1.0,
            constant: 20
        )
        
        superView?.addConstraint(Constraint)
        
        // my label의 끝에서 시작하는 거니까 equalTo: myLabel.trailingAnchor -> leadingAnchor
        myLabel2.leadingAnchor.constraint(equalTo: myLabel.trailingAnchor, constant: 30).isActive = true
        myLabel2.firstBaselineAnchor.constraint(equalTo: myLabel.firstBaselineAnchor, constant: 0).isActive = true
        
    }
    
    
    
    
    
}
