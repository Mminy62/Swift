//
//  AttractionTableViewController.swift
//  TableViewStoryDemo
//
//  Created by 이민영 on 2023/11/16.
//

import UIKit

class AttractionTableViewController: UITableViewController {

    // 테이블 목록
    var attractionImages = [String]()
    var attractionNames = [String]()
    var webAddresses = [String]()
    
    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        //edit가 끝나면 초기화 하게 만드는 함수
        initialize()
        
    }
    
    // 테이블 뷰 데이터 소스 생성
    // 앱이 로드될 때 일부 데이터로 배열을 초기화
    func initialize(){
        attractionNames = ["Buckingham Palace",
                           "The Eiffel Tower",
                           "The Grand Canyon",
                           "Windsor Castle",
                           "Empire State Building"]
        
        webAddresses = ["https://en.wikipedia.org/wiki/Buckingham_Palace",
                        "https://en.wikipedia.org/wiki/Eiffel_Tower",
                        "https://en.wikipedia.org/wiki/Grand_Canyon",
                        "https://en.wikipedia.org/wiki/Windsor_Castle",
                        "https://en.wikipedia.org/wiki/Empire_State_Building"]
        
        attractionImages = ["buckingham_palace.jpg",
                            "eiffel_tower.jpg",
                            "grand_canyon.jpg",
                            "windsor_castle.jpg",
                            "empire_state_building.jpg"]
        
        // 테이블 뷰의 예상 행 높이 설정
        // 테이블 보기 탐색을 추가할 때 행 높이가 축소되는 것을 방지하고, 테이블 렌더링 성능도 향상
        
        self.tableView.estimatedRowHeight = 50
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            
            return attractionNames.count
    }

    // 셀에 디자인 한 것을 입혀준다
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 스토리보드 Id 설정한 뷰의 ID를 넣는 것 -> with Identifier

        // 'AttractionTableCell' 부분은 스토리보드 화면에서 테이블 뷰 셀'Table View Cell' 의 Identifier 에 넣은 이름으로 채움
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttractionTableCell", for: indexPath) as! AttractionTableViewCell
        

         //Configure the cell...
        // indexPath.row -> 각 row별 index
        let row = indexPath.row
        cell.attractionLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cell.attractionLabel.text = attractionNames[row]
        cell.attractionImage.image = UIImage(named: attractionImages[row])
        
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

    
    // 목록 이동하기
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            self.attractionNames.remove(at: row)
            self.attractionImages.remove(at: row)
            self.webAddresses.remove(at: row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        
            else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Delete를 한글로 변경
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    

    // 목록 순서 바꾸기
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        // 이동할 아이템 위치를 기록
        var row = fromIndexPath.row
        
        // 이동할 아이템을 삭제
        let attractionName = self.attractionNames.remove(at: row)
        let attractionImage = self.attractionImages.remove(at: row)
        let webAddress = self.webAddresses.remove(at: row)
        
        // 삭제된 아이템을 이동할 위치로 삽입
        row = to.row
        self.attractionNames.insert(attractionName, at: row)
        self.attractionImages.insert(attractionImage, at:row)
        self.webAddresses.insert(webAddress, at:row)
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    // data 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowAttractionDetails" {
            let detailView = segue.destination as! AttractionDetailViewController

            // 현재 테이블 뷰에 선택된 행의 순서를 가져옴
            let row = self.tableView.indexPathForSelectedRow!.row
            detailView.webSite = webAddresses[row]
        }
        
    }
    

}
