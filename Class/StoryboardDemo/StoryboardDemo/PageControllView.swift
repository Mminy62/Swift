//
//  PageControllView.swift
//  StoryboardDemo
//
//  Created by 이민영 on 2023/11/15.
//

import Foundation
import UIKit

class PageControllView: UIViewController{
    var imgWidth = 300
       var imgHeight = 200

       let images = ["waterfall.png", "IMG_1258.jpeg", "IMG_1259.jpeg", "IMG_1260.jpeg", "IMG_1261.jpeg", "lion.jpeg"]
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
}
