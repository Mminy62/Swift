//
//  ViewController.swift
//  DatabaseDemo
//
//  Created by 이민영 on 2023/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var status: UILabel!
    
    @IBOutlet var resultName: UITextField!
    @IBOutlet var resultAddress: UITextField!
    @IBOutlet var resultPhone: UITextField!
    var databasePath = ""
    
    var items = [Contact]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initDB()
    }
    
    func initDB(){
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)

        databasePath = dirPaths[0].appendingPathExtension("contacts.db").path

        if  !filemgr.fileExists(atPath: databasePath) {
            
            let contactDB = FMDatabase(path: databasePath)
            if contactDB.open() {
                let sql_stmt = "create table if not exists contacts ( id integer primary key autoincrement, name text, address text, phone text)"
                if !contactDB.executeStatements(sql_stmt) {
                    print("Error: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
            } else {
                print("Error: \(contactDB.lastErrorMessage())")
            }
        } // end if
        
    }
    
    
    @IBAction func saveContact(_ sender: Any) {
        
        let newContact = Contact(id: 0, name: name.text, address: address.text, phone: phone.text)
        let (success, message) = Contact.save(contact: newContact, databasePath: databasePath)

        status.text = message

        if success {
            name.text = ""
            address.text = ""
            phone.text = ""
        }
    }
    
    @IBAction func findContact(_ sender: Any) {
        
        items = Contact.findName(name: name.text ?? "", databasePath: databasePath)
        
        if items.count > 0 {
            let item = items[0]
            address.text = item.address
            phone.text = item.phone
            status.text = "Record Found"
        } else {
            status.text = "Record Not Found"
            address.text = ""
            phone.text = ""
        }
        
        for i in items {
            print("\(i.address ?? ""), \(i.phone ?? "")" )
        }
    }
    
        
    

    @IBAction func nextContact(_ sender: Any) {
        if items.isEmpty {
            resultName.text = ""
            resultAddress.text = ""
            resultPhone.text = ""
            
        } else {
            index = (index + 1) % items.count
            resultName.text = items[index].name
            resultAddress.text = items[index].address
            resultPhone.text = items[index].phone
        }
        
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        
        
    }
    
    
}

struct Contact{
    let id: Int?
    let name: String?
    let address: String?
    let phone: String?
        
    static func save(contact: Contact, databasePath: String) -> (success: Bool, message: String) {
        let contactDB = FMDatabase(path: databasePath)
        
        if contactDB.open() {
            let sql = "insert into contacts (name, address, phone) values ('\(contact.name ?? "")', '\(contact.address ?? "")','\(contact.phone ?? "")')"
            
            do {
                try contactDB.executeUpdate(sql, values: nil)
            } catch {
                return (false, "contact 추가 실패!!")
            }
            
            contactDB.close()
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
            return (false, "DB 열기 오류발생")
        }
        
        return (true, "Contact Added")
    }
    
    static func findName(name: String, databasePath: String) -> [Contact] {
        let contactDB = FMDatabase(path: databasePath)
        var items = [Contact]()
        
        if contactDB.open() {
            let sql = "select id, name, address, phone from contacts where name='\(name)'"
            
            do {
                let results: FMResultSet? = try contactDB.executeQuery(sql, values: nil)
                
                while results?.next() == true {
                    let id = results?.int(forColumn: "id") ?? 0
                    let name = results?.string(forColumn: "name") ?? ""
                    let address = results?.string(forColumn: "address") ?? ""
                    let phone = results?.string(forColumn: "phone") ?? ""
                    
                    items.append(Contact(id: Int(id), name: name, address: address, phone: phone))
                }
                
            } catch {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            
            contactDB.close()
            
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        return items
    }
}

