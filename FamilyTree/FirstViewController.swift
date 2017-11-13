//
//  ViewController.swift
//  test
//
//  Created by 伊藤修平 on 2017/10/05.
//  Copyright © 2017 Shuhei Ito. All rights reserved.
//

import UIKit
import RealmSwift

class FirstViewController: UIViewController, UIScrollViewDelegate {

  @IBOutlet weak var scrollView: UIScrollView!

  var selfView: UIView? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.delegate = self
    scrollView.contentSize = CGSize(width: 5000, height: 5000)
    scrollView.minimumZoomScale = 0.5;
    scrollView.maximumZoomScale = 5.0;
    scrollView.isScrollEnabled = true
    scrollView.zoomScale = 1
    scrollView.clipsToBounds = false
    
    var myItems : [Person] = []
    let realm = try! Realm()
    let myItemsObj = realm.objects(Person.self)
    myItems = []
    myItemsObj.forEach { item in
      myItems.append(item)
      print(item)
    }
    let p = AllocationPerson()
    p.draw(items: myItems)
    myItems.forEach{ item in
      
      let addView = PersonCustomView()
      let pos = p.getPosition(tagid: j)
      addView.frame = CGRect(x: pos.0, y: pos.1, width: 120, height: 120)
      addView.tag = j
      addView.isUserInteractionEnabled = true
      addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
      addView.familyName.text = item.familyname
      addView.givenName.text = item.givenname
      scrollView.addSubview(addView)
      
      i += 240
      j += 1
    }
    main()
  }
  
  func main() {
    var myself = Relation(father: 1,mother: 2)
    families.append(myself)
    var father = Relation(father: 3,mother: 4)
    families.append(father)
    var mother = Relation(father: -1,mother: -1)
    families.append(mother)
    var gfather = Relation(father: -1,mother: -1)
    families.append(gfather)
    var gmother = Relation(father: -1,mother: -1)
    families.append(gmother)
    
    myself.setFather(father: father.getUserId())
    myself.setMother(mother: mother.getUserId())
    mother.setFather(father: gfather.getUserId())
    mother.setMother(mother: gmother.getUserId())
    print(getDepth(p: 0,d: -1))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  var i = 240
  var familyname = ""
  var givenname = ""
  var birthday = Date()
  //var deathday = Date()
  var j = 1
  var flg = true
  
  @IBAction func tappedAddButton(_ sender: Any) {
    flg = true
    editPersonalInfo(familyname: "", givenname: "", sex: 2)
  }
  
  var tappedPersonCustomView : PersonCustomView? = nil
  
  @objc func viewTapped(sender: UITapGestureRecognizer){
    print("tappedPersonCustomView",sender.view as Any)

    flg = false
    
    tappedPersonCustomView = (sender.view as! PersonCustomView)
    let lastname = tappedPersonCustomView?.familyName.text
    let firstname = tappedPersonCustomView?.givenName.text
    let realm = try! Realm()
    let person = realm.objects(Person.self).filter("id == %@",sender.view!.tag)

    editPersonalInfo(familyname: lastname!, givenname: firstname!, sex: person[0].sex)
    
  }
  
  
  @IBAction func backToFirstViewController(segue: UIStoryboardSegue) {
    let a = segue.source as! SecondViewController
    familyname = a.familyname.text!
    givenname = a.givenname.text!
    let sex = a.sex.selectedSegmentIndex
    let father = a.father.text!
    //let mother = a.mother.text!
    let strBirthday = a.birthday.text!
    
    let split = father.components(separatedBy: " ")
    var fathersdob:Date = Date()
    var fathersname:String = ""
    if split.count != 1 {
      fathersdob = stringToDate(tstr: split[1])!
      print("split",split)
      fathersname = split[0]
    }
    
    
    
    var fathersid = -1
    var myItems : [Person] = []
    let realm = try! Realm()
    let myItemsObj = realm.objects(Person.self);
    myItems = []
    print("fathersname", fathersname)
    print("fathersdob", fathersdob)
    myItemsObj.forEach { item in
      print(item)
      if (item.givenname == fathersname && dateToString(tdate: item.birthday) == dateToString(tdate: fathersdob)) {
        fathersid = item.id
      }
    }

    // from AddButton
    if flg {
      let addView = PersonCustomView()
      addView.frame = CGRect(x: i, y: i, width: 120, height: 120)
      addView.tag = j
      addView.isUserInteractionEnabled = true
      addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
      addView.familyName.text = familyname
      addView.givenName.text = givenname
      scrollView.addSubview(addView)
      
      let birthday = stringToDate(tstr: strBirthday)

      let realm = try! Realm()
      let person = Person()
      
      person.id = addView.tag
      person.familyname = familyname
      person.givenname = givenname
      person.sex = sex
      person.birthday = birthday!
      
      if addView.tag == 1 {
        selfView = addView
      }
      
      try! realm.write {
        realm.add(person)
      }
      i += 240
      j += 1
    } else {  //from CustomView
      tappedPersonCustomView?.familyName.text = familyname
      tappedPersonCustomView?.givenName.text = givenname
      print("tappedPersonCustomView!.tag", tappedPersonCustomView!.tag)
      let tappedId = tappedPersonCustomView!.tag
      let realm = try! Realm()
      let updatePerson = realm.objects(Person.self).filter("id == %@",tappedId)
      if let person = updatePerson.first {
        try! realm.write {
          person.familyname = familyname
          person.givenname = givenname
          person.birthday = birthday
        }
      }
    }
  }
  

  @objc override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    for touch: UITouch in touches {
      let tag = touch.view!.tag
      if tag == 1 {
        dismiss(animated: true, completion: nil)
      }
    }
  }
  
  // storyboard SecondView
  func editPersonalInfo(familyname: String, givenname: String, sex: Int) {
    let editPersonalInformation:SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "editPersonalInformation") as! SecondViewController
    self.present(editPersonalInformation, animated: true, completion: nil)
    editPersonalInformation.familyname.text = familyname
    editPersonalInformation.givenname.text = givenname
    editPersonalInformation.sex.selectedSegmentIndex = sex
    
    print("editPersonalInfomation", familyname, sex)
  }
  
  @IBAction func tappedDeleteButton(_ sender: Any) {
    let realm = try! Realm()
    
    try! realm.write {
      realm.deleteAll()
    }
    if Realm.Configuration.defaultConfiguration.fileURL != nil {  
      print(Realm.Configuration.defaultConfiguration.fileURL!)
      try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
      
    }
    print("delete")
  }
  
  func stringToDate (tstr: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")!
    dateFormatter.locale = Locale(identifier: "ja_JP")
    dateFormatter.dateFormat = "yyyy/MM/dd"
    let date = dateFormatter.date(from: tstr)
    print(date?.description ?? "nilです")    // 2016-10-03 03:12:12 +0000
    return date
  }
  
  func dateToString (tdate: Date) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")!
    dateFormatter.locale = Locale(identifier: "ja_JP")
    dateFormatter.dateFormat = "yyyy/MM/dd"
    let date = dateFormatter.string(from: tdate)
    
    return date
    }
  
  
  // set allocation
  
  
  


}

