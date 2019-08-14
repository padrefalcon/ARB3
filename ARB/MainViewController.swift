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
        
        planView.layer.shadowColor = UIColor.black.cgColor
        planView.layer.shadowOffset = CGSize(width: 1, height: 1)
        planView.layer.shadowRadius = 7
        planView.layer.cornerRadius = 20
        planView.layer.shadowOpacity = 0.5

        factView.layer.shadowColor = UIColor.black.cgColor
        factView.layer.shadowOffset = CGSize(width: 1, height: 1)
        factView.layer.shadowRadius = 7
        factView.layer.cornerRadius = 20
        factView.layer.shadowOpacity = 0.5

        budgetView.layer.shadowColor = UIColor.black.cgColor
        budgetView.layer.shadowOffset = CGSize(width: 1, height: 1)
        budgetView.layer.shadowRadius = 7
        budgetView.layer.cornerRadius = 20
        budgetView.layer.shadowOpacity = 0.7
     
        percentView.layer.shadowColor = UIColor.black.cgColor
        percentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        percentView.layer.shadowRadius = 7
        percentView.layer.cornerRadius = 20
        percentView.layer.shadowOpacity = 0.7
        
        
        getDataRoomList(jsonUrlString: "http://89.223.26.123:7777") {
            self.sumPlan.text = separatedNumber(rooms[0].summPlan) + " р"
            self.sumFact.text = separatedNumber(rooms[0].summFact) + " р"
            self.percent.text = separatedNumber(rooms[0].recent) + " %"
            if rooms[0].budget < 0 { self.budget.textColor = UIColor.cyan} else { self.budget.textColor = UIColor.red }
            self.budget.text = separatedNumber(rooms[0].budget) + " р"
        }
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
