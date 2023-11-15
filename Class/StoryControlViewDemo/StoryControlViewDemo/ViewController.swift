//
//  ViewController.swift
//  StoryControlViewDemo
//
//  Created by 이민영 on 2023/11/15.
//

import UIKit

class ViewController: UIViewController {
    var imgWidth = 300
    var imgHeight = 200
    
    let images = ["nature.png", "ocean.png", "simon.png"]
    var imgIndex = 0
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.frame.size = CGSize(width: imgWidth, height: imgHeight)
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = images.count
    }
    
    @IBAction func pageChangeImg(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[sender.currentPage])
        
        imgIndex = sender.currentPage
    }
    
    @IBAction func btnChangeImg(_ sender: UIButton) {
        
        if imgIndex < images.count {
            imgView.image = UIImage(named: images[imgIndex])
            imgIndex += 1
        } else {
            imgIndex = 0
        }
    }
    
    @IBAction func switchImgSize(_ sender: UISwitch) {
        if sender.isOn {
            imgView.frame.size = CGSize(width: imgWidth, height: imgHeight)
        } else {
            let halfWidth = imgView.frame.width / 2
            let halfHeight = imgView.frame.height / 2
            
            imgView.frame.size = CGSize(width: halfWidth, height: halfHeight)
        }
    }
    
    
    // 장면 간 데이터 연결
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! Scene2ViewController
        dest.labelText = "첫 화면에서 값을 보냄!!"
    }
    
    // 두번째 장면이 종료되었을 때 나타나는 함수
    @IBAction func returned(segue: UIStoryboardSegue) {
    }
    
    @IBAction func returned2(segue: UIStoryboardSegue) {
    }


}

