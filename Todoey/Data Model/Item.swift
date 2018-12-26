//
//  Item.swift
//  Todoey
//
//  Created by Mihails Frolovs on 23/12/2018.
//  Copyright © 2018 Mihails Frolovs. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var date : Date?
    var parenCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
