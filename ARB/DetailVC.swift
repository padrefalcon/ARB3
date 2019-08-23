//
//  DetailVC.swift
//  ARB
//
//  Created by DMITRIY DETKIN on 14/08/2019.
//  Copyright © 2019 DMITRIY DETKIN. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var workName: UILabel!
    @IBOutlet weak var workType: UILabel!
    @IBOutlet weak var pushSaveoutlet: UIButton!
    
    @IBOutlet weak var summPlan: UILabel!
    @IBOutlet weak var summFact: UITextField!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var unitValue: UILabel!
    
    
    @IBAction func pushSave(_ sender: Any) {
        let id = roomid
        let summ = Int(summFact.text ?? "") ?? 0
        let url = "http://89.223.26.123:7777/save/sf?id=\(id)&summ=\(summ)"
        uploadSaveData(jsonUrlString: url) {
            self.pushSaveoutlet.isEnabled = false
            self.viewDidLoad()
            self.navigationController?.popToRootViewController(animated: true)
//            navigationController
//            self.performSegue(withIdentifier: "backToParent", sender: self)
        }
        
    }
    
    var roomid: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomid = room[0].id
        roomName.text = room[0].roomName
        workName.text = room[0].workName
        workType.text = room[0].workType
        let a = String(format: "%.01f", room[0].unitValue)
        let unitsDetail = "\(a) \(room[0].units) x \(separatedNumber(room[0].priseOne))"
        unitValue.text = unitsDetail
        
        summPlan.text = separatedNumber(room[0].summPlan) + "p"
        summFact.placeholder = separatedNumber(room[0].summFact) + "p"
        if (room[0].summFact > 0) && (room[0].summPlan > 0) {
            let prc = room[0].summFact/room[0].summPlan * 100
        percent.text = separatedNumber(prc) + "%"
        } else {
            percent.text = "0 %"
        }
        let bdg = room[0].summFact - room[0].summPlan
        if (bdg < 0) {
            budget.textColor = UIColor.blue
        } else { budget.textColor = UIColor.red }
            
        budget.text = separatedNumber(bdg)
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        pushSaveoutlet.isEnabled = true
        view.endEditing(true)
//        self.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let sumfact = Double(summFact.text ?? "") ?? 0.0
        if (room[0].summPlan > 0) && ( sumfact > 0) {
            let prc = sumfact / room[0].summPlan
            percent.text = separatedNumber(prc * 100) + "%"
            
            let bdg = room[0].summPlan - sumfact
            if (bdg < 0) {
                budget.textColor = UIColor.blue
            } else { budget.textColor = UIColor.red }
            budget.text = separatedNumber(bdg)
        } else {
            percent.text = "0 %"
        }
        pushSaveoutlet.isEnabled = true
        self.view.endEditing(true)
        
        return true
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
