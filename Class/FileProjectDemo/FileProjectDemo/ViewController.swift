//
//  ViewController.swift
//  FileProjectDemo
//
//  Created by 이민영 on 2023/11/20.
//
import Foundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet var textBox: UITextField!
    
    var fileMgr = FileManager.default
    var dataFile: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 처음 뷰가 로드될때 체크 파일
        checkFile()
    }
    
    // 사용자가 앱을 시작할 때마다 데이터 파일이 존재하는지 확인
    // 파일이 존재하는 경우 앱에서 콘텐츠를 읽고 텍스트 필드에 표시
    // - 사용자가 이전에 텍스트를 저장하지 않은 경우 파일이 생성되지 않음
    func checkFile(){
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        // 문서 디렉토리가 어디에 있는지 알고 나면 파일이 존재하는 확인하기 전에
        // 파일(dataFile.dat)의 전체 경로를 구성
        // 문서 디렉토리에 파일 이름 추가
        // /Users/min-yeong/Documents/~ 뒤에 datafile.dat을 붙이는 것
        dataFile = dirPaths[0].appendingPathComponent("datafile.dat").path

        // 파일이 존재하는 경우 파일 내용을 읽고, 텍스트필드에 넣음
        if fileMgr.fileExists(atPath: dataFile) {

            if let databuffer = fileMgr.contents(atPath: dataFile) {
                let datastring = NSString(data: databuffer, encoding: String.Encoding.utf8.rawValue)
                textBox.text = datastring as String?
            }
        }
    
    }

    @IBAction func saveText(_ sender: Any) {
        // 텍스트필드 객체의 텍스트를 변환하고 이를 Data 객체에 할당
        // 그 내용을 파일 관리자 객채의 createFile() 메서드를 호출하여 파일에 기록
        if let text = textBox?.text {
            let databuffer = text.data(using: String.Encoding.utf8)
            fileMgr.createFile(atPath: dataFile, contents: databuffer, attributes: nil)

            simpleAlert("저장성공!!")
        }
    }
    
    // alert 알림창
    func simpleAlert(_ message: String){
        let alert = UIAlertController(title: "Save", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}

