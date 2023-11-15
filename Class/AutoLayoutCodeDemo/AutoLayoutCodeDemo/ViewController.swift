//
//  ViewController.swift
//  AutoLayoutCodeDemo
//
//  Created by 이민영 on 2023/11/13.
//

import UIKit

class ViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        
////        createLayout()
//        createImageLayout()
    createVisulFormatLayout()
//    }
    
    
    
    func createImageLayout(){
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // 제약조건 주는 중에만 꺼주면 됨
        
        self.view.addSubview(imageView)
        
        let constraints = [
                    imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 200),
                    imageView.heightAnchor.constraint(equalToConstant: 200)
                ]

        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    func createLayout(){
        // 상위뷰 표시
        let superView = self.view
        
        let myLabel = UILabel()
        // 코드가 아닌 기본 layout 설정과 겹칠때를 대비하여, 기본 속성 꺼주기
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "MyLabel"
        
        
        let myButton = UIButton()
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.setTitle("My Button", for: UIControl.State.normal)
        myButton.backgroundColor = UIColor.blue
        
        superView?.addSubview(myLabel)
        superView?.addSubview(myButton)
        
        // 제약 조건 생성 및 추가 제약 조건
        // 가운데에 놓고 싶으면 왼오 기준 YY, XX로 나눠서 써야한다
//        var myConstraint =
//                 NSLayoutConstraint(item: myLabel,
//                                    attribute: NSLayoutConstraint.Attribute.centerY,
//                                    relatedBy: NSLayoutConstraint.Relation.equal,
//                                    toItem: superView,
//                                    attribute: NSLayoutConstraint.Attribute.centerY,
//                                    multiplier: 1.0,
//                                    constant: 0)
//
//        superView?.addConstraint(myConstraint)
//
//               myConstraint =
//                 NSLayoutConstraint(item: myLabel,
//                                    attribute: NSLayoutConstraint.Attribute.centerX,
//                                    relatedBy: NSLayoutConstraint.Relation.equal,
//                                    toItem: superView,
//                                    attribute: NSLayoutConstraint.Attribute.centerX,
//                                    multiplier: 1.0,
//                                    constant: 0)
//
//        superView?.addConstraint(myConstraint)
    
//        myConstraint =
//        NSLayoutConstraint(item: myButton,
//                           attribute: NSLayoutConstraint.Attribute.trailing, // 오른쪽기준
//                           relatedBy: NSLayoutConstraint.Relation.equal,
//                           toItem: myLabel,
//                           attribute: NSLayoutConstraint.Attribute.leading, // 왼쪽기준
//                           multiplier: 1.0,
//                           constant: 0)
//        
//       
//        superView?.addConstraint(myConstraint)
        
//        
//        myConstraint =
//                  NSLayoutConstraint(item: myButton,
//                                     attribute: NSLayoutConstraint.Attribute.firstBaseline,
//                                     relatedBy: NSLayoutConstraint.Relation.equal,
//                                     toItem: myLabel,
//                                     attribute: NSLayoutConstraint.Attribute.firstBaseline,
//                                     multiplier: 1.0,
//                                     constant: 0)
//
//        superView?.addConstraint(myConstraint)
        
        
        
        myLabel.centerXAnchor.constraint(equalTo: superView!.centerXAnchor).isActive = true
        myLabel.centerYAnchor.constraint(equalTo: superView!.centerYAnchor).isActive = true
        myButton.trailingAnchor.constraint(equalTo: myLabel.leadingAnchor, constant: -10).isActive = true
        
        var btnConst = myButton.firstBaselineAnchor.constraint(equalTo: myLabel.firstBaselineAnchor)
        
        //...
        btnConst.isActive = true
        
    }


}

