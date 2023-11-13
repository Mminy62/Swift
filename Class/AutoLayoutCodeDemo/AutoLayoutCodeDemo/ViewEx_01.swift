//
//  ViewEx_01.swift
//  AutoLayoutCodeDemo
//
//  Created by 이민영 on 2023/11/13.
//


import UIKit

class ViewEx_01: UIViewController {
    
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
        
        
        superView?.addSubview(myLabel)
        
        myLabel.centerXAnchor.constraint(equalTo: superView!.leadingAnchor, constant: 30).isActive = true
        myLabel.centerYAnchor.constraint(equalTo: superView!.centerYAnchor).isActive = true
        
        
        let myLabel2 = UILabel()
        myLabel2.translatesAutoresizingMaskIntoConstraints = false
        myLabel2.text = "World"
        
        superView?.addSubview(myLabel2)
        
        var Label2Constraint =
        NSLayoutConstraint(item: myLabel2,
                           attribute: NSLayoutConstraint.Attribute.leading,
                           relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: myLabel,
                           attribute: NSLayoutConstraint.Attribute.trailing,
                           multiplier: 1.0,
                           constant: 20)
        
        
        superView?.addConstraint(Label2Constraint)
        
        Label2Constraint =
        NSLayoutConstraint(item: myLabel2,
                           attribute: NSLayoutConstraint.Attribute.firstBaseline,
                           relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: myLabel,
                           attribute: NSLayoutConstraint.Attribute.firstBaseline,
                           multiplier: 1.0,
                           constant: 0)
        
        superView?.addConstraint(Label2Constraint)
    }
}
