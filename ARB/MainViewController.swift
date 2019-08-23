//
//  MainViewController.swift
//  ARB
//
//  Created by DMITRIY DETKIN on 08/08/2019.
//  Copyright © 2019 DMITRIY DETKIN. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var sumPlan: UILabel!
    @IBOutlet weak var sumFact: UILabel!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var planView: UIView!
    @IBOutlet weak var budgetView: UIView!
    @IBOutlet weak var payDima: UILabel!
    @IBOutlet weak var payLena: UILabel!
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var payAll: UILabel!
    @IBOutlet weak var fotoDima: UIImageView!
    @IBOutlet weak var fotoLena: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        planView.layer.shadowColor = UIColor.black.cgColor
//        planView.layer.shadowOffset = CGSize(width: 1, height: 1)
//        planView.layer.shadowRadius = 5
//        planView.layer.shadowOpacity = 0.5
        planView.layer.cornerRadius = 20
        

//        budgetView.layer.shadowColor = UIColor.black.cgColor
//        budgetView.layer.shadowOffset = CGSize(width: 1, height: 1)
//        budgetView.layer.shadowRadius = 5
//        budgetView.layer.shadowOpacity = 0.7
        budgetView.layer.cornerRadius = 20
        
        
//        payView.layer.shadowColor = UIColor.black.cgColor
//        payView.layer.shadowOffset = CGSize(width: 1, height: 1)
//        payView.layer.shadowRadius = 5
//        payView.layer.shadowOpacity = 0.7
        payView.layer.cornerRadius = 20
        
        fotoDima.layer.cornerRadius = 20
        fotoLena.layer.cornerRadius = 20
        
        getDataRoomList(jsonUrlString: "http://89.223.26.123:7777") {
            self.sumPlan.text = separatedNumber(rooms[0].summPlan) //+ " р"
            self.sumFact.text = separatedNumber(rooms[0].summFact)// + " р"
            
            if (rooms[0].summFact > rooms[0].summPlan) {
                self.sumFact.textColor = UIColor.red
            } else {
                self.sumFact.textColor = UIColor.cyan
            }
            
            if (rooms[0].summPlan > 0) && (rooms[0].summFact > 0) {
                let prc = rooms[0].summFact / rooms[0].summPlan * 100
                if (prc < 100) {
                    self.percent.textColor = UIColor.cyan
                } else {
                    self.percent.textColor = UIColor.red
                }
                self.percent.text = separatedNumber(prc) + " %"
            } else {
                self.percent.text = "0 %"
            }
            
            if rooms[0].budget <= 0 { self.budget.textColor = UIColor.cyan} else { self.budget.textColor = UIColor.red }
            self.budget.text = separatedNumber(rooms[0].budget) + " р"
        }
        
        getDataPayAll(jsonUrlString: "http://89.223.26.123:7777/p") {
            if (paysAll[0].name == "Дима") {
                self.payDima.text = separatedNumber(paysAll[0].summ)
                self.payLena.text = separatedNumber(paysAll[1].summ)
            } else {
                self.payDima.text = separatedNumber(paysAll[1].summ)
                self.payLena.text = separatedNumber(paysAll[0].summ)
            }
            let a = paysAll[1].summ + paysAll[0].summ
//            let b = rooms[0].summFact
//            let prc = a/b
            let payAllStr = separatedNumber(a)
            self.payAll.text = payAllStr
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRooms" {
         let controller = (segue.destination as! ListFirstLevelView)
            controller.dataLevel = 1
        }
        
        if segue.identifier == "showWorks" {
            let controller = (segue.destination as! ListFirstLevelView)
            controller.dataLevel = 3
        }
    }
   

}
