///Users/itoshuhei/Project/Swift/FamilyTree/FamilyTree/Person.swift
//  PersonCustomView.swift
//  test
//
//  Created by 伊藤修平 on 2017/10/06.
//  Copyright © 2017 Shuhei Ito. All rights reserved.
//

import UIKit

class PersonCustomView: UIView {


  @IBOutlet weak var familyName: UILabel!
  @IBOutlet weak var givenName: UILabel!
  
  override init(frame: CGRect){
    super.init(frame: frame)
    loadNib()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    loadNib()
  }
  
  func loadNib(){
    let view = Bundle.main.loadNibNamed("PersonCustomView", owner: self, options: nil)?.first as! UIView
    view.frame = self.bounds
    self.addSubview(view)
  }
}

