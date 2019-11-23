//
//  PayView.swift
//  ARB
//
//  Created by DMITRIY DETKIN on 20/08/2019.
//  Copyright © 2019 DMITRIY DETKIN. All rights reserved.
//

import UIKit
class payCell :UITableViewCell {
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var summ: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    func configure(by pay: pay) {
        userImage.layer.cornerRadius = 20
        
        let dimaImg = UIImage(named: "Dima")
        let lenaImg = UIImage(named: "Lena")
        if (pay.user == "Дима") {
            userImage.image = dimaImg
        } else {
            userImage.image = lenaImg
        }
        type.text = pay.type
        comment.text = pay.comment
        date.text = pay.date
        summ.text = separatedNumber(pay.summ)
    }
    
    func configure2(by pay: pay2) {
        userImage.layer.cornerRadius = 20
        
//        let dimaImg = UIImage(named: "Dima")
//        let lenaImg = UIImage(named: "Lena")
//        if (pay.user == "Дима") {
//            userImage.image = dimaImg
//        } else {
//            userImage.image = lenaImg
//        }
        type.text = pay.type
//        comment.text = pay.comment
//        date.text = pay.date
        summ.text = separatedNumber(pay.summ)
    }
}

class PayView: UITableViewController {
    
    var payDataSource = [[String]]()
    
   
    
    
    @IBOutlet weak var paySortType: UIBarButtonItem!
    @IBAction func pushSortType(_ sender: Any) {
        if (paySortType.title == "По дате") {
            paySortType.title = "По Типу"
            loadData()
        } else {
            paySortType.title = "По дате"
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadData()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    private func loadData() {
        if (paySortType.title == "По дате") {
            
            getDataPay(jsonUrlString: "http://89.223.26.123:7777/p/all" ) {
                self.navigationItem.title = "Платежи-Дата"
                self.tableView.reloadData()
            }
        }
        
        if (paySortType.title == "По Типу") {
            
            getDataPay(jsonUrlString: "http://89.223.26.123:7777/p/all2" ) {
                self.navigationItem.title = "Платежи-Тип"
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source

    func getUniqPayTypes() -> [String] {
        var fullArray:[String] = []
        pays.forEach { (type) in
            fullArray.append(type.type)
        }
        let uniqArray = Array(Set(fullArray))
        //         print(uniqArray)
        return uniqArray
        
    }
//    // Create a standard header that includes the returned text.
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection
//        section: Int) -> String? {
//        return "Header \(section)"
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        let a = getUniqPayTypes()
//        return a.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        print(pays.count)
        return pays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "payCell", for: indexPath) as! payCell
        
        

            let p = pays[indexPath.row]
            if (p.user == "Дима") {
                cell.backgroundColor = #colorLiteral(red: 0.8778790236, green: 0.99674505, blue: 0.965611279, alpha: 1)
            } else {
                cell.backgroundColor = #colorLiteral(red: 0.9857015014, green: 0.9078420997, blue: 0.9913361669, alpha: 1)
            }
            cell.configure(by: p)
        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let idPay = pays[indexPath.row].idpay
            
            let url = "http://89.223.26.123:7777/save/spd?idpay=\(idPay)"
            deletePay(jsonUrlString: url) {
//                tableView.deleteRows(at: [indexPath], with: .fade)
                self.loadData()
                self.tableView.reloadData()
            }
            // Delete the row from the data source
            
        } //else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
