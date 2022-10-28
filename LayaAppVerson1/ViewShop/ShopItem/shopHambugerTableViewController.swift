//
//  shopHambugerTableViewController.swift
//  LayaAppVerson1
//
//  Created by Sheng-Yu on 2022/10/28.
//

import UIKit

class shopHambugerTableViewController: UITableViewController {
    
    
    var meal:[ShopItemSet] = []
    
    var drink = [ShopItemSet(name: "紅茶", price: 0),
                 ShopItemSet(name: "玄米煎茶", price: 0),
                 ShopItemSet(name: "奶茶", price: 5),
                 ShopItemSet(name: "豆漿", price: 5),
                 ShopItemSet(name: "蘋果茶", price: 5),
                 ShopItemSet(name: "薏仁漿", price: 10),
                 ShopItemSet(name: "鮮檸冬瓜", price: 10),
                 ShopItemSet(name: "可可", price: 15),
                 ShopItemSet(name: "青檸紅茶", price: 15),
                 ShopItemSet(name: "柳橙汁", price: 15),
                 ShopItemSet(name: "柚香蜂蜜檸檬", price: 15),
                 ShopItemSet(name: "紅茶拿鐵", price: 20),
                 ShopItemSet(name: "奶酪奶茶", price: 29),
                 ShopItemSet(name: "美式咖啡", price: 15),
                 ShopItemSet(name: "拿鐵咖啡", price: 25),
                 ShopItemSet(name: "鴛鴦咖啡", price: 25),
    ]
    

    var toppingSet = [ShopItemSet(name: "請點選加購品項", price: 0),
                      ShopItemSet(name: "三角薯餅(3塊)(原價25元)", price: 20),
                      ShopItemSet(name: "麥克雞塊(4塊)(原價35元)", price: 30),
                      ShopItemSet(name: "美式雞柳條(原價45元)", price: 40),]
    
    var textFieledWriting = ""
    
    var toppingAndDrink:[String] = []
    
    var numberSum = 1
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let foodSection = ShopItemSetSection(rawValue: section)!
        switch foodSection{
        case.meal:
            return "主餐"
        case.drink:
            return "套餐20元飲料"
        case.toppingGrade:
            return "加料升級優惠(現省5元)"
        }
   
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return meal.count
        }
        else if section == 1 {
            return toppingAndDrink.count
        }
        else {
            return toppingSet.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopHambugerTableViewCell.reuseIdentifeir , for: indexPath) as! ShopHambugerTableViewCell
        
        let food:ShopItemSet
        if indexPath.section == 0{
            food = meal[indexPath.row]
        }
        else if indexPath.section == 1  {
            food = drink[indexPath.row]
        }
        else{
            food = toppingSet[indexPath.row]
        }
        cell.itemName.text = food.name
        cell.itemPrice.text = "+$\(food.price)"
        cell.itemAdd.isSelected = food.isadd
    
        return cell
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
