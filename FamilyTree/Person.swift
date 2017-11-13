//
//  Person.swift
//  FamilyTree
//
//  Created by 伊藤修平 on 2017/10/10.
//  Copyright © 2017 Shuhei Ito. All rights reserved.
//

import RealmSwift

class Person: Object {
  @objc dynamic var id = 0
  @objc dynamic var familyname = ""
  @objc dynamic var givenname = ""
  @objc dynamic var birthday = Date()
  @objc dynamic var deathday = Date()
  @objc dynamic var fatherid = 0
  @objc dynamic var motherid = 0
  @objc dynamic var aged = 0
  @objc dynamic var sex = 2
  @objc dynamic var memo = ""

}
