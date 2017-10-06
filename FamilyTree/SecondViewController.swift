//
//  SecondViewController.swift
//  test
//
//  Created by 伊藤修平 on 2017/10/05.
//  Copyright © 2017 Shuhei Ito. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

  @IBOutlet weak var lastname: UITextField!
  @IBOutlet weak var firstname: UITextField!
  @IBOutlet weak var birthday: UITextField!
  @IBOutlet weak var father: UITextField!
  @IBOutlet weak var mother: UITextField!
  @IBOutlet weak var spouse: UITextField!
  
  
  var stringArray : [String] = []
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
