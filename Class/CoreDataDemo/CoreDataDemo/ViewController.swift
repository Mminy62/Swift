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
    @IBOutlet var status: UILabel!
    
    // 관리 객체 컨텍스트 객체에 대한 참조를 저장할 변수를 선언
    // filemanager 느낌
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
        if let context = self.manageObjectContext, let entityDescription = NSEntityDescription.entity(forEntityName: "Contacts", in: context) {

       let contact = Contacts(entity: entityDescription, insertInto: manageObjectContext)

       contact.name = name.text
       contact.address = address.text
       contact.phone = phone.text

       do {
           try manageObjectContext?.save()

           name.text = ""
           address.text = ""
           phone.text = ""
           status.text = "Contact Added"
       } catch let error {
           status.text = error.localizedDescription
       }

   }
    }
    
    @IBAction func findContact(_ sender: Any) {
        
        if let context = self.manageObjectContext, let entityDescription = NSEntityDescription.entity(forEntityName: "Contacts", in: context) {

                    let request: NSFetchRequest<Contacts> = Contacts.fetchRequest()
                    request.entity = entityDescription

                    if let name = name.text {
                        let pred = NSPredicate(format: "(name = %@)", name)
                        request.predicate = pred
                    }

                    do {
                        let results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)

                        if results.count > 0 {
                            let match = results[0] as! NSManagedObject

                            name.text = match.value(forKey: "name") as? String
                            address.text = match.value(forKey: "address") as? String
                            phone.text = match.value(forKey: "phone") as? String
                            status.text = "Sucess Find : \(results.count)"
                        } else {
                            status.text = "Fail Find"
                        }
                    } catch let error {
                        status.text = error.localizedDescription
                    }

                }
    }
}
