//
//  HamburgerPepperTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/11/10.
//

import UIKit

class HamburgerPepperTableViewController: UITableViewController {
    
//    var toppingsAll:[String] = ["冰","中杯"]
    var toppingsTopping:ShopItemSet!
    

    @IBOutlet weak var pepperButton: UIButton!
    @IBOutlet weak var itemNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("加胡椒啦",toppingsTopping.choices)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.title = toppingsTopping.name
        
    }
    override func viewWillAppear(_ animated: Bool) {

        if toppingsTopping.choices.contains("香料"){
            pepperButton.isSelected = false
        }
        else{
            pepperButton.isSelected = true
        }
        
    }
    
    @IBAction func backHamburger(_ sender: Any) {
        guard let navigationCotroller = self.navigationController else { return }
        let count = navigationCotroller.viewControllers.count
        let gobackList = self.navigationController?.viewControllers[ count - 2] as! shopHambugerTableViewController
            //傳值
            gobackList.toppingsTopping = toppingsTopping
            navigationCotroller.popToViewController(gobackList, animated: true)
    }
    
    @IBAction func addPepper(_ sender: UIButton) {
        sender.isSelected.toggle()
        toppingsTopping.choices = []
        if sender.isSelected{
            toppingsTopping.choices.append(itemNameLabel.text!)
            toppingsTopping.isadd = true
            print("加胡椒啦讚喔",toppingsTopping.choices)
            print("加胡椒啦讚喔",toppingsTopping.isadd)
            
        }
        else {
            toppingsTopping.isadd = false
            toppingsTopping.choices = ["香料"]
            
            
            print("好棒棒",toppingsTopping.choices)
            print("好棒棒",toppingsTopping.isadd)
        }
//        else if sender.isSelected == false{
//            var index = 0
//            for (j,pepper) in toppingsTopping.choices.enumerated(){
//                if pepper == itemNameLabel.text!{
//                    j == index
//                }
//                toppingsTopping.choices.remove(at: index)
//            }
//        }
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
