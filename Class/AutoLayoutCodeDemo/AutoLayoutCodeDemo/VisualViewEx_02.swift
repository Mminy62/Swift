//
//  VisualViewEx_02.swift
//  AutoLayoutCodeDemo
//
//  Created by 이민영 on 2023/11/14.
//


import Foundation
import UIKit

class VisualViewEx_02: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createVisualFormatLayout()
    }

    func createVisualFormatLayout() {
        let superview = self.view!
        
        let leftview = UIView()
        leftview.translatesAutoresizingMaskIntoConstraints = false
        leftview.backgroundColor = UIColor.red

        let rightview = UIView()
        rightview.translatesAutoresizingMaskIntoConstraints = false
        rightview.backgroundColor = UIColor.green

        superview.addSubview(leftview)
        superview.addSubview(rightview)

        // 뷰 사전 생성
        // Visual Format
        let views = ["leftview": leftview, "rightview": rightview]
        
        
        var constraint = NSLayoutConstraint.constraints(withVisualFormat: "|-10-[leftview(200@50)]-10-[rightview(100@100)]-10-|",
                                                        options: [],
                                                        metrics: nil,
                                                        views: views)
        constraint += NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[leftview(50)]|",
                                                     options: [],
                                                     metrics: nil,
                                                     views: views)
        constraint += NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[rightview(50)]|",
                                                     options: [],
                                                     metrics: nil,
                                                     views: views)

        view.addConstraints(constraint)

    }
}
