//
//  ViewController.swift
//  StoryboardDemo
//
//  Created by 이민영 on 2023/11/15.
//

import UIKit

class ViewController: UIViewController {
    
    var imgWidth = 300
    var imgHeight = 200
    
    let images = ["ocean.png", "nature.png"]
    var isNature = false
    
    var imgIndex = 0
    

    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.frame.size = CGSize(width: imgWidth, height: imgHeight)
        
    }

    @IBAction func btnChangeImg(_ sender: Any) {
        
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
    

}

