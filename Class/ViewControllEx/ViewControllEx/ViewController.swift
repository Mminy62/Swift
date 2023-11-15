//
//  ViewController.swift
//  ViewControllEx
//
//  Created by 이민영 on 2023/11/15.
//

import UIKit

class ViewController: UIViewController {
    
    let texts = ["하루에 3시간을 걸으면\n7년 후에 지구를 한 바퀴 돌 수 있다\n_사무엘 존슨_", "성공은 실패 가능성과 패배의 위험을 무릅쓰고 얻어야 한다.\n위험 없이는 성취의 보람도 없다.\n_레어크록_ ", "계획이 없는 목표는 한낱 꿈에 불과하다.\n_생텍쥐페리_"]
    
    var index = 0

    @IBOutlet var textView: UITextView!
    
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = texts.count
    }
    
    

    @IBAction func changeText(_ sender: UIPageControl) {
        
        textView.text = texts[pageControl.currentPage]
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! View2Controller
        dest.labelText = "Today's List"
    }
    
    
    
}

