//
//  TableViewController.swift
//  IceCreamApp
//
//  Created by 이민영 on 2023/11/23.
//

import Foundation
import UIKit
import CoreData

class IceCreamTableViewController : UITableViewController{
    
    // 테이블 목록
    var itemImages = [Data]()
    var itemNames = [String]()

    var manageObjectContext: NSManagedObjectContext?
    
    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCoreData()
        initialize()
    
        
    }
    
    func initCoreData() {
            let container = NSPersistentContainer(name: "IceCreamApp")
            container.loadPersistentStores(completionHandler: { (description, error) in
                if let error = error {
                    fatalError("initCoreData Error: \(error)")
                } else {
                    self.manageObjectContext = container.viewContext
                }
            })
    }
    
    // 테이블 뷰 데이터 소스 생성
    // 앱이 로드될 때 일부 데이터로 배열을 초기화
    func initialize(){
        
        if let context = self.manageObjectContext, let _ = NSEntityDescription.entity(forEntityName: "IceCream", in: context) {
            let request = IceCream.fetchRequest() as NSFetchRequest<IceCream>
            var resultStr = ""
            do {
                let results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
                
                // 검색된 관리 개체의 데이터 액세스
                for item  in results {
                    print( (item as! IceCream).name ?? "")
                    let match = item as! NSManagedObject
                    
                    let image = match.value(forKey: "image") as! Data
                    let name = match.value(forKey: "name") as? String
                    itemImages.append(image)
                    itemNames.append((name) ?? "" )
                    
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
    
        }
        
        
//        itemImages = ["buckingham_palace.jpg",
//                      "eiffel_tower.jpg",
//                      "grand_canyon.jpg",
//                      "windsor_castle.jpg",
//                      "empire_state_building.jpg"]
//        
//        itemNames = ["https://en.wikipedia.org/wiki/Buckingham_Palace",
//                        "https://en.wikipedia.org/wiki/Eiffel_Tower",
//                        "https://en.wikipedia.org/wiki/Grand_Canyon",
//                        "https://en.wikipedia.org/wiki/Windsor_Castle",
//                        "https://en.wikipedia.org/wiki/Empire_State_Building"]
//    
        
        // 테이블 뷰의 예상 행 높이 설정
        // 테이블 보기 탐색을 추가할 때 행 높이가 축소되는 것을 방지하고, 테이블 렌더링 성능도 향상
        
        self.tableView.estimatedRowHeight = 120
        
//        navigationController?.navigationBar.prefersLargeTitles = true
    
        definesPresentationContext = true
    }
    
    
    
    // 뷰가 보일때 마다 리스트의 데이터 다시 불러옴
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }

    // MARK: - Table view data source

    // 테이블 안에 섹션이 1개
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // 목록들은 몇개로 나눠서 나오개 할 건지를 정하는 것
        return 1
    }
    

    // 섹션별 행의 개수 # 데이터 목록 개수
    // 검색 모드에서 행 수는 일치한 배열의 항목 수에 따라 달라짐
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemNames.count
    }

    // item 값을 셀에 추가
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 스토리보드 Id 설정한 뷰의 ID를 넣는 것 -> with Identifier

        // 'AttractionTableCell' 부분은 스토리보드 화면에서 테이블 뷰 셀'Table View Cell' 의 Identifier 에 넣은 이름으로 채움
        let cell = tableView.dequeueReusableCell(withIdentifier: "IceCreamTableCell", for: indexPath) as! IceCreamTableViewCell
        

         //Configure the cell...
        // indexPath.row -> 각 row별 index
        let row = indexPath.row
        cell.itemName.text = itemNames[row]
        let imageName = itemImages[row]
        cell.itemImage.image = UIImage(data: imageName)
        
        return cell
    }
    
    // uiKit 은 대부분. 클래스로 되어있고, 여기선 UITableView~~로 들어가보면 MainActor -> 메인 스레드에서 돌아가고 있다
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    
    // MARK: - Navigation
    //(검색 적용 완료)
//    // data 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetailView" {
            let detailView = segue.destination as! IceCreamDetailView

            // 현재 테이블 뷰에 선택된 행의 순서를 가져옴
            let row = self.tableView.indexPathForSelectedRow!.row
//            detailView.webSite = [row]
        }
        
    }
    

}
