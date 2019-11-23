//
//  ListFirstLevelV/Users/dmitriydetkin/Desktop/prj appt/ARB/ARB/MainViewController.swiftiew.swift
//  ARB
//
//  Created by DMITRIY DETKIN on 09/08/2019.
//  Copyright © 2019 DMITRIY DETKIN. All rights reserved.
//

import UIKit

class myCell: UITableViewCell {
   
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var summPlan: UILabel!
    @IBOutlet weak var summFact: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var roomName2: UILabel!
    
    func configureByRoom(by room: roomList) {
        roomName.text = room.roomName
        summPlan.text = separatedNumber(room.summPlan)// + " p"
        summFact.text = separatedNumber(room.summFact) // + " p"
        if (room.summPlan > 0) && (room.summFact > 0) {
            let prc = room.summFact / room.summPlan * 100
            percent.text = separatedNumber(prc)  + " %"
        } else {
            percent.text = "0 %"
        }
        
        let economy = room.budget ?? 0
        if economy > 0 {
            budget.textColor = .red
        } else if economy == 0 {
            budget.textColor = .darkGray
        } else {
            budget.textColor = .blue
        }
        budget.text = separatedNumber(room.budget) //+ "p"
    }
    
    func configureByRoom2(by room: roomList) {
        roomName.text = room.workName
        roomName2.text = room.workType
        summPlan.text = separatedNumber(room.summPlan)// + " p"
        summFact.text = separatedNumber(room.summFact) // + " p"
        if (room.summPlan > 0) && (room.summFact > 0) {
            let prc = room.summFact / room.summPlan * 100
            percent.text = separatedNumber(prc)  + " %"
        } else {
            percent.text = "0 %"
        }
        let economy = room.budget ?? 0
        if economy > 0 {
            budget.textColor = .red
        } else if economy == 0 {
            budget.textColor = .darkGray
        } else {
            budget.textColor = .blue
        }
        budget.text = separatedNumber(room.budget)// + "p"
        
    }
    
    func configureByWork(by room: roomList) {
        roomName.text = room.workType
        summPlan.text = separatedNumber(room.summPlan)// + " p"
        summFact.text = separatedNumber(room.summFact)//  + " p"
        if (room.summPlan > 0) && (room.summFact > 0) {
            let prc = room.summFact / room.summPlan * 100
            percent.text = separatedNumber(prc)  + " %"
        } else {
            percent.text = "0 %"
        }
        let economy = room.budget ?? 0
        if economy > 0 {
            budget.textColor = .red
        } else if economy == 0 {
            budget.textColor = .darkGray
        } else {
            budget.textColor = .blue
        }
        budget.text = separatedNumber(room.budget)// + "p"
    }
    
    func configureByWork2(by room: roomList) {
        roomName.text = room.workName //+ room.roomName
        roomName2.text = room.roomName2
        summPlan.text = separatedNumber(room.summPlan) //+ " p"
        summFact.text = separatedNumber(room.summFact) // + " p"
        if (room.summPlan > 0) && (room.summFact > 0) {
            let prc = room.summFact / room.summPlan * 100
            percent.text = separatedNumber(prc)  + " %"
        } else {
            percent.text = "0 %"
        }
        let economy = room.budget ?? 0
        if economy > 0 {
            budget.textColor = .red
        } else if economy == 0 {
            budget.textColor = .darkGray
        } else {
            budget.textColor = .blue
        }
        budget.text = separatedNumber(room.budget) //+ "p"
    }
    
    
}

class ListFirstLevelView: UITableViewController {
    
    var dataLevel: Int  = 0
    var dataSubLevel: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
       
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        loadData()
//    }
    
    private func loadData() {
        if dataLevel == 1 {
        getDataRoomList(jsonUrlString: "http://89.223.26.123:7777/a/all") {
            //print(rooms)
            self.navigationItem.title = "Список комнат"
            self.tableView.reloadData()
        }
        }
        
        if dataLevel == 3 {
            getDataRoomList(jsonUrlString: "http://89.223.26.123:7777/w/all") {
                //print(rooms)
                self.navigationItem.title = "Список работ"
                self.tableView.reloadData()
            }
        }
        
    }
        
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//            return rooms.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rooms.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! myCell
//        cell.roomName.text = "test"
        let r = rooms[indexPath.row]
//        print(r)
//        if (dataLevel == 1) {cell.configure(by: r)} else { cell.configure2(by: r) }
        if (dataLevel == 1)  {cell.configureByRoom(by: r)}
        if (dataLevel == 2)  {cell.configureByRoom2(by: r)}
        if (dataLevel == 3)  {cell.configureByWork(by: r)}
        if (dataLevel == 4)  {cell.configureByWork2(by: r)}
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (dataLevel == 1) {
            dataLevel = 2
            dataSubLevel = 1
        let selectedRoomName = rooms[indexPath.row].roomName
        
        let urlText = "http://89.223.26.123:7777/a/detail?name="
        let escapedRoomName = String( selectedRoomName.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        getDataRoomList(jsonUrlString: "\(urlText)\(escapedRoomName)") {
            
            self.tableView.numberOfRows(inSection: rooms.count)
            self.navigationItem.title = selectedRoomName
            self.tableView.reloadData()
            
        }
            return
        }
        
        if (dataLevel == 3) {
            dataLevel = 4
            dataSubLevel = 1
            let selectedRoomName = rooms[indexPath.row].workType
            let urlText = "http://89.223.26.123:7777/w/detail?name="
            let escapedRoomName = String( selectedRoomName.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
            getDataRoomList(jsonUrlString: "\(urlText)\(escapedRoomName)") {
//                print(rooms.count)
//                print(self.tableView.numberOfRows(inSection: 0))
                self.tableView.numberOfRows(inSection: 0)
                self.navigationItem.title = selectedRoomName
                self.tableView.reloadData()
                
            }
            return
        }
        
        if (dataSubLevel == 1) {
            let selectedRoomID = String(rooms[indexPath.row].ID)
            let urlText = "http://89.223.26.123:7777/a/detail?id=\(selectedRoomID)"
            getDataRoomDetail(jsonUrlString: "\(urlText)") {
            self.performSegue(withIdentifier: "showDetailVC", sender: self)
            }
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
