//
//  FileNameSize.swift
//  FileProjectDemo
//
//  Created by 이민영 on 2023/11/20.
//

import Foundation
import UIKit
import SwiftUI

class FileNameSize: UIViewController {
    
    var files: [String] = []
    var sourcePath = "/Users/imin-yeong/Documents"
    var ddfile: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        checkFile()
    }
    
    // 사용자가 앱을 시작할 때마다 데이터 파일이 존재하는지 확인
    // 파일이 존재하는 경우 앱에서 콘텐츠를 읽고 텍스트 필드에 표시
    // - 사용자가 이전에 텍스트를 저장하지 않은 경우 파일이 생성되지 않음
    func checkFile(){
        
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        do {
            files = try fileManager.contentsOfDirectory(atPath: currentPath)
            

            
        } catch {
            print(error)
        }
    
    }
    
    @IBSegueAction func fileInfoListView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIListView(items: files))
    }
}
 
