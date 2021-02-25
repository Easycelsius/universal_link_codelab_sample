//
//  ToDoCoreDataProperties.swift
//  MyTodoApp
//
//  Created by Suhyun Sophia Lee on 2021/02/25.
//  Copyright © 2021 Suhyun. All rights reserved.
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var content: String

}

extension ToDo : Identifiable {

}
