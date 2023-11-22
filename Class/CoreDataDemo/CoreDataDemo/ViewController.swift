//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by 이민영 on 2023/11/22.
//

import UIKit
import CoreData // CoreData 프레임워크 가져오기

class ViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var phone: UITextField!
    
    // 관리 객체 컨텍스트 객체에 대한 참조를 저장할 변수를 선언
    var manageObjectContext: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initCoreData()
    }
    
    func initCoreData(){
        // 스토리지 container 이름을 만들고
        let container = NSPersistentContainer(name: "CoreDataDemo")
        // Persistant Storage를 초기화 하는 것
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError("")
            } else {
                self.manageObjectContext = container.viewContext
            }
        })
    }

    @IBAction func saveContact(_ sender: Any) {
    }
    
    @IBAction func findContact(_ sender: Any) {
    }
}

