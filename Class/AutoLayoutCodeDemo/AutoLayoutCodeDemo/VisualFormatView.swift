//
//  VisualFormatView.swift
//  AutoLayoutCodeDemo
//
//  Created by 이민영 on 2023/11/14.
//

import Foundation
import UIKit

class VisualFormatView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        createLayout()
//        createImageLayout()
//        createLayoutEx05()
        createVisualFormatLayout()
    }

    func createVisualFormatLayout() {
        let superview = self.view!

        let myLabel = UILabel()
        myLabel.text = "My Label"
        myLabel.translatesAutoresizingMaskIntoConstraints = false

        let myButton = UIButton()
        myButton.setTitle("My Button", for: .normal)
        myButton.backgroundColor = UIColor.blue
        myButton.translatesAutoresizingMaskIntoConstraints = false

        superview.addSubview(myLabel)
        superview.addSubview(myButton)

        // 뷰 사전 생성
        let viewsDict = ["mylabel": myLabel, "myButton": myButton]

        var myConstarints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[myButton(100)]-|", metrics: nil, views: viewsDict)
        
        myConstarints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[myButton]-|", metrics: nil, views: viewsDict)
        
        
        superview.addConstraints(myConstarints)

    }
}
