//
//  ViewController.swift
//  IceCreamApp
//
//  Created by 이민영 on 2023/11/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var name: UITextField!
    @IBOutlet var flavor: UITextField!
    
    var imagePicker = UIImagePickerController()
    var arrData: [IceCream]?
    // 관리 객체 컨텍스트 객체에 대한 참조를 저장할 변수를 선언
    var manageObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initCoreData()
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
    
    
    
    @IBAction func pickImageButtonPressed(_ sender: Any) {
        
        self.openImagePicker()
    }
    
    
    @IBAction func saveImageButtonPressed(_ sender: Any) {
        
        if let context = self.manageObjectContext, let entityDescription = NSEntityDescription.entity(forEntityName: "IceCream", in: context) {
            
            let contact = IceCream(entity: entityDescription, insertInto: manageObjectContext)
            
            let png = imageView.image?.pngData()

            contact.image = png
            contact.name = name.text
            contact.flavor = flavor.text
            
            
            do {
                try manageObjectContext?.save()
                print("Contact Added")
                print(contact.name ?? "", contact.flavor ?? "")
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
                
    }
    
    
    @IBAction func findButtonPressed(_ sender: Any) {
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
                    
                    let image = match.value(forKey: "image") as! Data
                    imageView.image = UIImage(data: image)!
                    
                    print("Sucess Find : \(results.count)")
                    
                } else {
                    print("Fail Find : \(results.count)")
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate{
    func openImagePicker(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage{
            imageView.image = img
        }
    }
}
