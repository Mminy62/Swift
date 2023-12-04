//
//  NewsWebView.swift
//  SwiftAPIDemo
//
//  Created by 이민영 on 2023/12/04.
//

import SwiftUI
import WebKit
 
struct NewsWebView: UIViewRepresentable {
   
    
    var urlToLoad: String
    
    //ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        //unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        //웹뷰 인스턴스 생성
        let webView = WKWebView()
        
        //웹뷰를 로드한다
        webView.load(URLRequest(url: url))
        return webView
    }
    
    //업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<NewsWebView>) {
        
    }
}
 
//Canvas 미리보기용
//struct MyWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyWebView(urlToLoad: "https://www.naver.com")
//    }
//}
