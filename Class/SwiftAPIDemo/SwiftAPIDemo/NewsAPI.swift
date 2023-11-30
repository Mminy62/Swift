//
//  NewsApi.swift
//  SwiftAPIDemo
//
//  Created by 이민영 on 2023/11/30.
//

import Foundation
import SwiftUI

struct Results: Decodable {
    let articles: [Article]
}

struct Article: Decodable, Hashable{
    let title: String
    let url: String
    let urlToImage: String?
    
}

class NewsAPI: ObservableObject{
    static let shared = NewsAPI()
    private init() { }
    @Published var posts = [Article]()
    
    private var apiKey: String?{
        get {
            let keyfilename = "ApiKeys"
            let api_key = "API_KEY"
            // 생성한 .plist 파일 경로 불러오기
            // 파일 이름, 형식 넣어서 main.path 사용하기
            guard let filePath = Bundle.main.path(forResource: keyfilename, ofType: "plist") else {
                fatalError("Could not find \(keyfilename).plist")
            }
            
            // .plist 파일 내용을 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)
            
            // 딕셔너리에서 키 찾기
            guard let value = plist?.object(forKey: api_key) as? String else {
                fatalError("Could not find key \(api_key)")
            }
            
            return value
        }
    }

    func fetchData(){
        guard let apiKey = apiKey else { return }
        
        let urlString = "https://newsapi.org/v2/everything?q=Apple&from=2023-11-29&sortBy=popularity&apiKey=\(apiKey)"
        
        // string -> url 객체로
        guard let url = URL(string: urlString) else { return }
        // URLSession 설정
        let session = URLSession(configuration: .default)
        
        // dataTask() 메서드의 with: 매개변수에 url 또는 request 객체를 가지고 통신
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // 정상적으로 값이 오지 않았을 때 처리
                let posts = []
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
//            let str = String(decoding: data, as: UTF8.self)
//            print(str)
            
            do{
                let response = try JSONDecoder().decode(Results.self, from: data)
                print(response.articles.count)
                // 이미지로 인한 비동기처리 dispatchQueue
                DispatchQueue.main.async {
                    self.posts = response.articles
                }
            } catch let error {
                print(error.localizedDescription)
            }
            

        }
        task.resume()
    
    }
    
}
