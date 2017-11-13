//
//  SecondViewController.swift
//  test
//
//  Created by 伊藤修平 on 2017/10/05.
//  Copyright © 2017 Shuhei Ito. All rights reserved.
//

import UIKit
import RealmSwift


class SecondViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

  @IBOutlet weak var familyname: UITextField!
  @IBOutlet weak var givenname: UITextField!
  @IBOutlet weak var birthday: UITextField!
  @IBOutlet weak var deathday: UITextField!
  @IBOutlet weak var father: UITextField!
  @IBOutlet weak var mother: UITextField!
  @IBOutlet weak var spouse: UITextField!
  @IBOutlet weak var sex: UISegmentedControl!
  @IBOutlet weak var age: UILabel!
  @IBOutlet weak var aged: UILabel!
  @IBOutlet weak var memo: UITextView!
  
  var pickOption = [""]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pickOption.removeAll()
    pickOption.append("")
    
    let realm = try! Realm()
    let persons = realm.objects(Person.self)
    
    for p in persons{
//      print(p.givenname)
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "ja_JP")
      dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")!
      dateFormatter.dateFormat = "yyyy/MM/dd"
      let date = dateFormatter.string(from: p.birthday)
//      print(date)     // 2017/04/04
      pickOption.append(p.givenname + " " + date)
    }
    
    // father
    let pickerView = UIPickerView()
    pickerView.delegate = self
    pickerView.dataSource = self
    pickerView.showsSelectionIndicator = true
    father.inputView = pickerView
    
    // birthday
    let datePickerView = UIDatePicker()
    pickerView.delegate = self
    pickerView.showsSelectionIndicator = true
    datePickerView.datePickerMode = UIDatePickerMode.date
    birthday.inputView = datePickerView
    datePickerView.addTarget(self, action: #selector(SecondViewController.datePickerValueChange), for: .valueChanged)
    
    // father
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 3, height: 35))
    let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SecondViewController.done))
    let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SecondViewController.done))
    toolbar.setItems([cancelItem, doneItem], animated: true)
    father.inputAccessoryView = toolbar
    familyname.delegate = self
    
    // birthday
    let toolbar2 = UIToolbar(frame: CGRect(x: 0, y: 0, width: 3, height: 35))
    let doneItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SecondViewController.done2))
    let cancelItem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SecondViewController.done2))
    toolbar2.setItems([cancelItem2, doneItem2], animated: true)
    birthday.inputAccessoryView = toolbar2
    familyname.delegate = self
    
  }
  
  @objc func datePickerValueChange(sender: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ja_JP")
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")!
    dateFormatter.dateFormat = "yyyy/MM/dd"
    birthday.text = dateFormatter.string(from: sender.date)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    print("textFieldDidBeginEditing:" + familyname.text!)
    return true
  }
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickOption.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    father.text = pickOption[row]
    return pickOption[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  // father.text = pickOption[row]
  }
  
  // 2 is birthday
  
  @objc func done() {
    father.endEditing(true)
  }
  
  @objc func cancel() {
    father.text = ""
    father.endEditing(true)
  }
  
  @objc func done2() {
    birthday.endEditing(true)
  }
  
  @objc func cancel2() {
    birthday.text = ""
    birthday.endEditing(true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  

}
