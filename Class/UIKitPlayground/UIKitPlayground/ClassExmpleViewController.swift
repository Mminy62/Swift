//
//  ClassExmpleViewController.swift
//  UIKitPlayground
//
//  Created by 이민영 on 2023/11/24.
//

import Foundation
import UIKit
class ClassExampleViewController: UIViewController {
    
    let exampleButton: UIButton = {
        var buttonConfig = UIButton.Configuration.borderedProminent()
        let btn: UIButton = UIButton()
        
        btn.configuration = buttonConfig
        btn.configuration?.buttonSize = .medium
        btn.configuration?.imagePadding = 5

        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.setTitle("Share", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.exampleButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
    }
    
    private func setupView() -> Void {
        self.view.backgroundColor = UIColor.systemBackground
        
        let views: [UIView] = [exampleButton]
        views.forEach { view in
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            self.exampleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.exampleButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc func didButtonTapped() -> Void {
        self.exampleButton.configuration?.showsActivityIndicator = true
    }
}
