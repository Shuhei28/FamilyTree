//
//  PersionCustomView.swift
//  test
//
//  Created by 伊藤修平 on 2017/10/06.
//  Copyright © 2017 Shuhei Ito. All rights reserved.
//

import UIKit

class PersionCustomView: UIView {

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
  //  親要素である ScrollView のheight を増やす
  //  新たな要素をScrollView.addSubview する
}
