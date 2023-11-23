//
//  IceCream+CoreDataProperties.swift
//  IceCreamApp
//
//  Created by 이민영 on 2023/11/23.
//
//

import Foundation
import CoreData


extension IceCream {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IceCream> {
        return NSFetchRequest<IceCream>(entityName: "IceCream")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var flavor: String?

}

extension IceCream : Identifiable {

}
