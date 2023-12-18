//
//  CollectionView.swift
//  UIKitPlayground
//
//  Created by 이민영 on 2023/11/24.
//

import Foundation
import UIKit

class CollectionViewExample: UIViewController {
    let collectionView: UICollectionView = {
        /* Cell custom layout */
        let cvLayout: UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 10
        cvLayout.scrollDirection = .vertical
        cvLayout.itemSize = CGSize(witdh: 60, height: 60)
        
        /* Cell */
        let cv: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    
    private func setupView() -> Void{
        
        self.view.backgroundColor = UIColor.systemBackground
        
        let views: [UIView] = [collectionView]
        views.forEach { view in
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            self.collectionView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            self.collectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            self.collectionView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }
    
}



extension CollectionViewExample: UICollectionViewDataSource {
    // 1개의 섹션 당 아이템 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    // 셀의 생김새
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // for -> 셀 1개당 패스 파라미터
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withResultIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.systemGray6
        return cell
    }
    

}

extension CollectionViewExample: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User is tapped \(indexPath.row) cell")
    }
}
