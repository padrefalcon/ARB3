//
//  AddPayVC.swift
//  ARB
//
//  Created by DMITRIY DETKIN on 21/08/2019.
//  Copyright © 2019 DMITRIY DETKIN. All rights reserved.
//

import UIKit

let payTypes:[String] = ["Демонтаж", "Монтаж", "Вывоз мусора", "Электрика","Ремонт","Материалы", "Техника","Отделка","Мебель","Документы"]

var payTypeSelectedIndex: Int = -1

struct saveRecord {
    var date: String
    var user: String
    var type: String
    var summ: Int
    var comment: String
    
    init() {
        date = ""
        user = ""
        type = ""
        summ = 0
        comment = ""
    }
    
}


class AddPayVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return payTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return payTypes[row]
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        typePicker.
//    }
    
    
    
    @IBOutlet weak var fotoDima: UIImageView!
    @IBOutlet weak var fotoLena: UIImageView!
    @IBOutlet weak var user: UISegmentedControl!
    
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var type: UIPickerView!
    @IBOutlet weak var summ: UITextField!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var pushSave: UIButton!
    
    @IBAction func pushSave(_ sender: Any) {
        var a: saveRecord = saveRecord()
        
        let b = DateFormatter()
        b.dateFormat = "yyyy-MM-dd"
        a.date = b.string(from: date.date)
        
        a.user = user.titleForSegment(at: user.selectedSegmentIndex)!
        
        var queryCharSet = NSCharacterSet.urlQueryAllowed
        queryCharSet.remove(charactersIn: "+&")
        
        a.type = payTypes[payTypeSelectedIndex]
//        let escapedType = String(a.type.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let escapedType = String(a.type.addingPercentEncoding(withAllowedCharacters: queryCharSet)!)
//        let a1 = a.type.URLEncoded
        
        a.summ = Int(summ.text!) ?? 0
        
        a.comment = comment.text!
        
//        let escapedcomment = String(a.comment.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let escapedcomment = String(a.comment.addingPercentEncoding(withAllowedCharacters: queryCharSet)!)
//        let a2 = a.comment.URLEncoded
        
//        func createURLWithComponents() -> URL? {
//            var urlComponents = URLComponents()
//            urlComponents.scheme = "http"
//            urlComponents.host = "localhost:7777"
//            urlComponents.path = "save/sp"
//
//            let addressQuery1 = URLQueryItem(name: "date", value: a.date)
//            let addressQuery2 = URLQueryItem(name: "user", value: a.user)
//            let addressQuery3 = URLQueryItem(name: "type", value: escapedType)
//            let addressQuery4 = URLQueryItem(name: "summ", value: String(a.summ))
//            let addressQuery5 = URLQueryItem(name: "comment", value: escapedcomment)
//            urlComponents.queryItems = [addressQuery1,addressQuery2,addressQuery3,addressQuery4,addressQuery5]
//
//            return urlComponents.url
//        }
//        let url = createURLWithComponents()
//        let url = "http://89.223.26.123:7777/save/sp?date=\(a.date)&user=\(a.user)&type=\(escapedType)&summ=\(a.summ)&comment=\(escapedcomment)"
        let url = "http://89.223.26.123:7777/save/sp?date=\(a.date)&user=\(a.user)&type=\(a.type)&summ=\(a.summ)&comment=\(a.comment)"
        let escapedUrl = String(url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        uploadSaveData(jsonUrlString: escapedUrl) {
            self.pushSave.isEnabled = false
          self.navigationController?.popViewController(animated: true)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        payTypeSelectedIndex = row
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if (summ.text != "") && (comment.text != "") {
        pushSave.isEnabled = true
            view.endEditing(true)
            
        } else {
            self.resignFirstResponder()
        }
        //        self.viewDidLoad()
    }
    
    
    @IBAction func summEnd(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fotoDima.layer.cornerRadius = 20
        fotoLena.layer.cornerRadius = 20
        
        type.delegate = self
        type.dataSource = self
        
        type.selectedRow(inComponent: 0)
        payTypeSelectedIndex = 0
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
