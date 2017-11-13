//
//  AllocationPerson.swift
//  FamilyTree
//
//  Created by 伊藤修平 on 2017/10/23.
//  Copyright © 2017 Shuhei Ito. All rights reserved.
//

import UIKit

class AllocationPerson {
  
  var position:[(Int,Int)] = []

  func draw(items: [Person]) {
  
    position.append((-1,-1))
    items.forEach { item in
      if item.id == 1 {
        position.append((2500,2500))
        
      }else {
        position.append((0,0))
      }
    }
    if items.count != 0 {
      setFamiliesTree(items: items, tagid: 1)
    }
  }
  
  func getPosition(tagid: Int) -> (Int,Int) {
    return position[tagid]
  }
  
  func setFamiliesTree(items: [Person],tagid: Int) {
    if tagid != 1 {
      setFamiliesTree(items: items,tagid: items[tagid].fatherid)
      print(tagid)
      setFamiliesTree(items: items, tagid: items[tagid].motherid)
    }
  }
  
  
}
