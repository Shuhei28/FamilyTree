//
//  relation.swift
//  FamilyTree
//
//  Created by 伊藤修平 on 2017/10/16.
//  Copyright © 2017 Shuhei Ito. All rights reserved.
//

import UIKit

var i = 0
var families = [Relation]()
var d = -1

class Relation {
  var father = 0
  var mother = 0
  var uid = 0


  init(father: Int, mother: Int) {
    self.father = father
    self.mother = mother
    self.uid = i
    i += 1
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setFather(father: Int) {
    self.father = father
  }

  func setMother(mother: Int) {
    self.mother = mother
  }

  func getUserId() -> Int {
    return self.uid
  }

  func replace() {
    print("ID: \(uid) Father: \(father) Mother: \(mother)")
  }
}

func getDepth(p: Int, d: Int) {
  if p != -1 {
    print(families[p].father, terminator: "")
    getDepth(p: families[p].father, d: d+1)
    print(" ", families[p])
    getDepth(p: families[p].mother, d: d+1)

  }
}








