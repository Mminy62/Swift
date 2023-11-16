//
//  AttractionDetailViewController.swift
//  TableViewStoryDemo
//
//  Created by 이민영 on 2023/11/16.
//

import UIKit
import WebKit
class AttractionDetailViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var webSite: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let address = webSite, let webURL = URL(string: address){
            // 주소가 nil이 아니고 변환이 잘 됐으면,
            let urlRequest = URLRequest(url: webURL)
            webView.load(urlRequest)
        }
        
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
