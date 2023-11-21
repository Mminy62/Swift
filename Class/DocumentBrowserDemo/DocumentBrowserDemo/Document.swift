//
//  Document.swift
//  DocumentBrowserDemo
//
//  Created by 이민영 on 2023/11/21.
//

import UIKit

class Document: UIDocument {
    
    var userText: String? = ""
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let userContent = contents as? Data {
            userText = NSString(bytes: (contents as AnyObject).bytes, length: userContent.count, encoding: String.Encoding.utf8.rawValue) as String?
        }
    }
}

