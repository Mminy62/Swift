//
//  VisualViewEx_01.swift
//  AutoLayoutCodeDemo
//
//  Created by 이민영 on 2023/11/14.
//

import Foundation
import UIKit

class VisualViewEx_01: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createVisualFormatLayout()
    }

    func createVisualFormatLayout() {
        let superview = self.view!

        let myImage = UIImageView()
        myImage.image = UIImage(named: "dog")
        myImage.contentMode = .scaleAspectFit
        myImage.translatesAutoresizingMaskIntoConstraints = false

        superview.addSubview(myImage)


        // 뷰 사전 생성
        let viewsDict = ["myImage": myImage]

        var myConstarints = NSLayoutConstraint.constraints(withVisualFormat: "V:[myImage(200)]", metrics: nil, views: viewsDict)
        
        myConstarints += NSLayoutConstraint.constraints(withVisualFormat: "[myImage(200)]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: viewsDict)
        
        
        let centerXcons = NSLayoutConstraint(item: myImage, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        let centerYcons = NSLayoutConstraint(item: myImage, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([centerXcons] + [centerYcons])

    }
}
