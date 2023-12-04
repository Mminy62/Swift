//
//  ViewController.swift
//  Baskin
//
//  Created by 박선구 on 11/23/23.
//

import UIKit
import CoreData

class IceCreamDetailView: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var flavor: UILabel!
    @IBOutlet var calorie: UILabel!
    @IBOutlet var allergy: UILabel!
    
    var arrData: [IceCream]?
    var manageObjectContext: NSManagedObjectContext?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initCoreData()
        lookPage()
    }
    
    func initCoreData() {
        let container = NSPersistentContainer(name: "IceCreamApp")
        container.loadPersistentStores(completionHandler: {(description, error) in
            if let error = error {
                fatalError("initCoreData Error: \(error)")
            } else {
                self.manageObjectContext = container.viewContext
            }
        })
    }
    
    func lookPage() {
        if let context = self.manageObjectContext, let entityDescription = NSEntityDescription.entity(forEntityName: "IceCream", in: context) {
            
            // 사용자가 지정한 이름을 가진 객체만 저장소에서 검색되도록 보장하는 조건자를 제작
            let request: NSFetchRequest<IceCream> = IceCream.fetchRequest()
            request.entity = entityDescription
            
            if let name = name.text {
                let pred = NSPredicate(format: "(name LIKE %@)", "*\(name)*")
                request.predicate = pred
            }
            
            do {
                let results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
                
                // 검색된 관리 개체의 데이터 액세스
                if results.count > 0 {
                    let match = results[0] as! NSManagedObject
                    
                    name.text = match.value(forKey: "name") as? String
                    flavor.text = match.value(forKey: "flavor") as? String
                    calorie.text = match.value(forKey: "calorie") as? String
                    allergy.text = match.value(forKey: "allergy") as? String
                    
                    
                    let image = match.value(forKey: "image") as! Data
                    imageView.image = UIImage(data: image)!
                    
//                    print("Sucess Find : \(results.count)")
                    
                } else {
                    print("Fail Find : \(results.count)")
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
//    func loadFromCoreData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
//        guard let context = self.context else { return [] }
//        do {
//            let results = try context.fetch(request)
//            return results
//        } catch {
//            print(error.localizedDescription)
//            return []
//        }
//    }
    
    
}

