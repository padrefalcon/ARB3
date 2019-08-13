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
    @IBOutlet weak var factView: UIView!
    @IBOutlet weak var budgetView: UIView!
    @IBOutlet weak var percentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let shadowPath = UIBezierPath(rect: planView.bounds)
//        planView.layer.masksToBounds = false
//        planView.layer.shadowColor = UIColor.black.cgColor
//        planView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
//        planView.layer.shadowOpacity = 0.2
//        planView.layer.shadowPath = shadowPath.cgPath
//
        planView.layer.cornerRadius = 9
        planView.layer.masksToBounds = true
        
        factView.layer.cornerRadius = 9
        factView.layer.masksToBounds = true
        budgetView.layer.cornerRadius = 9
        budgetView.layer.masksToBounds = true
        percentView.layer.cornerRadius = 9
        percentView.layer.masksToBounds = true
        
        
//    getDataRoomList(jsonUrlString: "http://89.223.26.123:7777") {
//        self.sumPlan.text = separatedNumber(rooms[0].summPlan) + " р"
//        self.sumFact.text = separatedNumber(rooms[0].summFact) + " р"
//        self.percent.text = separatedNumber(rooms[0].recent) + " %"
//        if rooms[0].budget < 0 { self.budget.textColor = UIColor.cyan} else { self.budget.textColor = UIColor.red }
//        self.budget.text = separatedNumber(rooms[0].budget) + " р"
//    }
        getDataRoomList(jsonUrlString: "http://89.223.26.123:7777") {
//            print(rooms[0].summPlan)
            self.sumPlan.text = separatedNumber(rooms[0].summPlan) + " р"
            self.sumFact.text = separatedNumber(rooms[0].summFact) + " р"
            self.percent.text = separatedNumber(rooms[0].recent) + " %"
            if rooms[0].budget < 0 { self.budget.textColor = UIColor.cyan} else { self.budget.textColor = UIColor.red }
            self.budget.text = separatedNumber(rooms[0].budget) + " р"
        }
//        getDataRooms3(jsonUrlString: "http://89.223.26.123:7777") {
//            self.sumPlan.text = separatedNumber(rooms[0].summPlan) + " р"
//            self.sumFact.text = separatedNumber(rooms[0].summFact) + " р"
//            self.percent.text = separatedNumber(rooms[0].recent) + " %"
//            if rooms[0].budget < 0 { self.budget.textColor = UIColor.cyan} else { self.budget.textColor = UIColor.red }
//            self.budget.text = separatedNumber(rooms[0].budget) + " р"
//        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRooms" {
         let controller = (segue.destination as! ListFirstLevelView)
            controller.dataLevel = 1
//            controller.title = "Список комнат"
        }
        
        if segue.identifier == "showWorks" {
            let controller = (segue.destination as! ListFirstLevelView)
            controller.dataLevel = 3
          
        }
    }
   

}
