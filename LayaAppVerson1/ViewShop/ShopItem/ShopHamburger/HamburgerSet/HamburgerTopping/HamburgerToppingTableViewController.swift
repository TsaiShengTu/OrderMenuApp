//
//  HamburgerToppingTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/11/10.
//

import UIKit

class HamburgerToppingTableViewController: UITableViewController {
    
//    var toppingsAll:[String] = ["冰","中杯"]
    var toppingsMeal:ShopItemSet!
    var toppingsMealPrice = 0
    
    var toppings = [ShopItemFood(name: "加蛋", price: 15),
                   ShopItemFood(name: "加起司", price: 10),
                   ShopItemFood(name: "加培根", price: 10),
                   ShopItemFood(name: "加火腿", price: 10),
                    ShopItemFood(name: "去菜", price: 0),
                    ShopItemFood(name: "去番茄", price: 0),
                    ShopItemFood(name: "去醬", price: 0),]
    
    var sum = 0
    
    var mealsAndtopping:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.title = toppingsMeal.name
        
//        let drinkChoices = ["加蛋","加起司","加培根","加火腿","去菜","去番茄","去醬"]
//        //迴圈
//        for choice in drinkChoices {
//            //比對字串
//            let index = toppingsMeal.choices.firstIndex {
//                $0 == choice
//            }
//            //移除字串
//            if let index {
//                toppingsMeal.choices.remove(at: index)
//            }
//        }
    }
    
     override func viewWillAppear(_ animated: Bool) {
//         if toppingsMeal.choices.contains("請選擇加料"){
//
//             toppingsMeal.isSelected = false
//         }
//         else{
//             pepperButton.isSelected = true
//         }
         print("toppingViewWillAppear",toppings)
         tableView.reloadData()
    }
    
    

    @IBAction func checkTopping(_ sender: Any) {
        guard let navigationCotroller = self.navigationController else { return }
        let count = navigationCotroller.viewControllers.count
        let gobackList = self.navigationController?.viewControllers[ count - 2] as! shopHambugerTableViewController
            //傳值
        gobackList.toppingsMeal = toppingsMeal
        gobackList.toppingsMealShopItemFood = toppings
        gobackList.sum = sum
        navigationCotroller.popToViewController(gobackList, animated: true)
    }
    
    @IBAction func itemAdd(_ sender: UIButton) {
        //先清除傳值過來陣列當中全部的字串
        let drinkChoices = ["請選擇加料"]
        //迴圈
        for choice in drinkChoices {
            //比對字串
            let index = toppingsMeal.choices.firstIndex {
                $0 == choice
            }
            //移除字串
            if let index {
                toppingsMeal.choices.remove(at: index)
            }
        }
    
        let point = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point){
            let food:ShopItemFood
            
            toppings[indexPath.row].isadd.toggle()
            food = toppings[indexPath.row]
            
            if food.isadd{
                //判斷 點擊
                sum += food.price
                toppingsMeal.choices.append(food.name)
                
                
            }
            else{
                //判斷 點擊
                sum -= food.price
                var index = 0
                //比對字串的寫法
                for (i,orderitem) in toppingsMeal.choices.enumerated(){
                    if orderitem == food.name{
                        index = i
                    }
                }
                toppingsMeal.choices.remove(at: index)
                if toppingsMeal.choices.isEmpty{
                    toppingsMeal.choices.append("請選擇加料")
                }
            }
            print("mealsAndtopping", toppingsMeal.choices)
            print("isAdd",toppingsMeal.isadd)
            print("topping",toppings)
            print(sum)
            
        }
        tableView.reloadData()
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toppings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HamburgerToppingTableViewCell", for: indexPath) as! HamburgerToppingTableViewCell
        let item = toppings[indexPath.row]
        cell.itemNameLabel.text = item.name
        cell.itemPriceLabel.text = String("+$\(item.price)")
        cell.itemAdd.isSelected = item.isadd
        cell.itemAdd.tag = indexPath.row
        // Configure the cell...
        
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
