//
//  DocumentViewController.swift
//  DocumentBrowserDemo
//
//  Created by 이민영 on 2023/11/21.
//

import UIKit

class DocumentViewController: UIViewController {

    @IBOutlet weak var documentNameLabel: UILabel!

    @IBOutlet var documentText: UITextView!
    
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 파일이 있는 경우 -> 클릭했을 때 보이는 함수
        document?.open(completionHandler: { (success) in
            if success {
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                self.documentText.text = self.document?.userText
            } else {
                
            }
            })
    }
    

    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true)
    }
    
    @IBAction func saveFile(_ sender: Any) {
        document?.userText = documentText.text
        
        if let url = document?.fileURL{
            // 이미 파일이 있는 경우, 다시 생성할건지 오버라이팅 할건지 -> for
            document?.save(to: url, for: .forOverwriting, completionHandler: { (success) in
                print(url)
                if success{
                    print("File save OK!")
                } else {
                    print("File save failed!")
                }
            })
        }
        
    }
}
