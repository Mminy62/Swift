//
//  ViewController.swift
//  TempConvertDemo
//
//  Created by 이민영 on 2023/11/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var tempText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func convertTemp(_ sender: Any) {
        
        // text가 있으면 가져오고 없으면 함수 동작안하고 return
        guard let tempString = tempText.text else{
            return
        }
        
        if let fatreheit = Double(tempString){
            let celsius = (fatreheit - 32) / 1.8
            let resultText = "celsius \(celsius)"
            resultLabel.text = resultText
        } else {
            resultLabel.text = "입력오류 숫자만: \(tempString)"
        }
    }
    
    // 터치 이벤트 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //화면을 터치했을때 editing이 끝났다고 알려주는 것
        tempText.endEditing(true)
    }
    
    // enter/return 누르면 키패드가 없어지는 것
    @IBAction func textFieldReturn(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
}

// 키패드 사라지게 하는 법으로 -> touchesBegan (화면 터치이벤트)
//- enter/return 누르면 사라지는 것


