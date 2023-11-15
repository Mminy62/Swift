//
//  Scene2ViewController.swift
//  StoryControlViewDemo
//
//  Created by 이민영 on 2023/11/15.
//

import UIKit

class Scene2ViewController: UIViewController {
    
    
    @IBOutlet var sceneLabel: UILabel!
    
    // 장면 간 데이터 전달
    var labelText: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneLabel.text = labelText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
