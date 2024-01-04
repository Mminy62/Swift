//
//  Product.swift
//  FirebaseDemo0104
//
//  Created by 이민영 on 2024/01/04.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class ProductStore: ObservableObject {
    static let shared = ProductStore()
    
    init() {}
    
    @Published var products = [Product]()
    
    //Realtime Database의 기본 경로를 저장하는 변수
    let ref: DatabaseReference? = Database.database().reference()
    
    //Realtime Database의 데이터 구조는 기본적으로 JSON 형태
    // 저장소와 데이터를 주고받을 때 JSON 형식의 데이터로 주고받기 때문에 Encoder, Decoder의 인스턴스가 필요
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // 데이터베이스에 Product 인스턴스를 추가
    func addProduct(item: Product) {
        self.ref?.child("products").child("\(item.id)").setValue([
            "id": item.id,
            "name": item.name,
            "description": item.description,
            "isOrder": item.isOrder
        ])
    }
}

struct Product : Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var description: String
    var isOrder: Bool
}
