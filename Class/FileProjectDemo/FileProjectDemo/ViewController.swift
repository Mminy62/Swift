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
            //ex_01()
//            ex_02()
//            ex_03()
//            ex_04()
            ex_05()
        }
    }
    
    func ex_01(){
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        
        do{
            let files = try fileManager.contentsOfDirectory(atPath: currentPath)
            for file in files.sorted(){
                let filePath = currentPath + "/" + file
//                let attribs: NSDictionary = try fileManager.attributesOfItem(atPath: currentPath) as NSDictionary
//                print(attribs) // 디렉토리 안에 있는 각 파일에 속성들
//                let fileSize = attribs["NSFileSize"] as! UInt64
//                print(file)
                
                if let attribs = try? fileManager.attributesOfItem(atPath: filePath),
                   let filesize = attribs[.size] as? UInt64{
                    print("\(file): \(filesize)")
                }
                    
            }
        }
        catch{
            
        }
        
    }
    
    func ex_02(){
        let fileManager = FileManager.default
        
        do{
            let sourcePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].path
            let destinationPath = sourcePath + "/" + "Backup"
            
            try fileManager.createDirectory(atPath: destinationPath, withIntermediateDirectories: true)
            // sourcePath에 있는 파일들 가져오기
            let files = try fileManager.contentsOfDirectory(atPath: sourcePath)
            for file in files{
                let filePath = sourcePath + "/" + file
                //확장자 구분
                let fileExtension = (file as NSString).pathExtension.lowercased()
                // 파일 확장자가 "dat"인 것만 복사
                if fileExtension == "dat"{
                    let destinationFile = destinationPath + "/" + file
                    try fileManager.copyItem(atPath: filePath, toPath: destinationPath)

                }
            }
            
        } catch {
            print(error)
        }
    }
    
    
    func ex_03(){
        let fileManager = FileManager.default
        
        do{
            let sourceFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("data2file.dat").path
            let destinationFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("reversed.txt").path
            
            // 텍스트를 역순으로 바꾸어 저장하는 코드
            let data = try Data(contentsOf: URL(fileURLWithPath: sourceFile))
            if let text = String(data: data, encoding: .utf8){
                let reversedText = String(text.reversed())
                if let reverseData = reversedText.data(using: .utf8){
                    try reverseData.write(to: URL(fileURLWithPath: destinationFile))
                }
            }
            

            
        } catch {
            print(error)
        }
    }
    
    func ex_04(){
        let fileManager = FileManager.default
        
        do{
            let sourceFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("datafile.dat").path
            let destinationFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("summary.txt").path
            
            // 숫자들의 합계와 평균을 구하고 저장하는 코드를 작성하세요.
            let data = try Data(contentsOf: URL(fileURLWithPath: sourceFile))
            if let text = String(data: data, encoding: .utf8){
                let numbers = text.split(separator: ", ").compactMap{ Int($0) }
                let sum = numbers.reduce(0, +)
                
                let average = Double(sum) / Double(numbers.count)
                
                let summary = "합계: \(sum), 평균: \(average)"
                
                if let calData = summary.data(using: .utf8){
                    try calData.write(to: URL(fileURLWithPath: destinationFile))
                }
            }

        } catch {
            print(error)
        }
    }
    
    
    func ex_05(){
        let fileManager = FileManager.default
        
        do{
            let sourceFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("datafile.dat").path
            let destinationFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("frequency.txt").path
            
            // 숫자들의 합계와 평균을 구하고 저장하는 코드를 작성하세요.
            let data = try Data(contentsOf: URL(fileURLWithPath: sourceFile))
            if let text = String(data: data, encoding: .utf8){
                
                let words = text.split(separator: " ").map{ $0.lowercased() }
                var frequency = [String:Int]()
                for word in words{
                    frequency[word, default: 0] += 1
                }
                
                var result = ""
                for (word, count) in frequency{
                    result += "\(word): \(count)\n"
                }
                
                if let resultData = result.data(using: .utf8){
                    try resultData.write(to: URL(fileURLWithPath: destinationFile))
                }
            }

        } catch {
            print(error)
        }
    }
    
    // alert 알림창
    func simpleAlert(_ message: String){
        let alert = UIAlertController(title: "Save", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}

