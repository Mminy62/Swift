//
//  ViewController.swift
//  DelegateTest
//
//  Created by 이민영 on 2023/12/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var button: UIButton!
    @IBOutlet var enteredLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
    }

    // delegate 함수, UITextFieldDelegate 프로토콜에 이미 정의되어 있던 func textFieldShouldReturn를 부르는 것
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enteredLabel.text = textField.text
        return true
    }
//    @IBAction func buttonClicked(_ sender: Any) {
//        enteredLabel.text = textField.text
//    }
    
}

