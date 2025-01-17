//
//  StorageManager.swift
//  FirebaseDemo
//
//  Created by 이민영 on 2024/01/08.
//

import SwiftUI
import FirebaseStorage

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image {_ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
            
        }
    }
}

// StorageImage 모델
struct StorageImage : Hashable {
    var name: String
    var fullPath: String
    var image: UIImage
    
    init(name: String, fullPath: String, image: UIImage) {
        self.name = name
        self.fullPath = fullPath
        self.image = image
    }
}

class StorageManager: ObservableObject {
    static let shared = StorageManager()
    
    private init() {}
    @Published var images: [StorageImage] = []
    let storage = Storage.storage()
    
    func upload(image: UIImage) {
        let storageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
        
        // 함수에 전달된 이미지를 압축하여 JPEG 파일로 변환
        let resizedImage = image.aspectFittedToHeight(200)
        let data = resizedImage.jpegData(compressionQuality: 0.2) // 많이 압축한 것 20프로
        
        // Firebase Storage의 메타데이터에 업로드할 파일 형식을 변경
        // 변경하지 않으면 Firebase 저장소에 저장된 파일은 application/octat-stream 유형
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata, error == nil else {
                    print("Error while uploading file:", error!)
                    return
                }
                
                print("Metadata:", metadata)
            }
        }
    }
    
    
    // 하나의 항목만 나열
        func listItem() {
            // 이미지 폴더의 모든 파일을 나열
            let storageRef = storage.reference().child("images")

            storageRef.list(maxResults: 1) { result, error in
                guard let result = result, error == nil else {
                    return
                }

                self.images.removeAll()

                for item in result.items {
                    print("Item in images forder:", item)
                    print("Item in images fullPath:", item.fullPath)
                    item.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        guard let data = data, let image = UIImage(data: data), error == nil else {
                            return
                        }

                        self.images.append(
                            StorageImage(name: item.name, fullPath: item.fullPath, image: image))
                    }
                }

            }
        }

        // 항목 삭제
        func deleteItem(fullPath: String) {
            let item = storage.reference().child( fullPath )
            item.delete { error in
                guard error == nil else {
                    print("Error deleting item.", error!)
                    return
                }

                for (index, item) in self.images.enumerated() where fullPath == item.fullPath {
                    self.images.remove(at: index)
                }
            }
        }
    
    func listAllFiles() {
        // 이미지 폴더의 모든 파일을 나열
        let storageRef = storage.reference().child("images")
        
        storageRef.listAll { result, error in
            guard let result = result, error == nil else {
                return
            }
            
            self.images.removeAll()
            
            for item in result.items {
                print("Item in images forder:", item)
                print("Item in images fullPath:", item.fullPath)
                item.getData(maxSize: 1 * 1024 * 1024) { data, error in
                guard let data = data, let image = UIImage(data: data), error == nil else {
                    return
                }
                
                self.images.append(StorageImage(name: item.name, fullPath: item.fullPath, image: image))
                }
            }
            
        }
    }
    
    
}


