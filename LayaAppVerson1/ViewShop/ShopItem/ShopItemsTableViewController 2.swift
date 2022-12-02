//
//  ShopItemsTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/14.
//

import UIKit
import Kingfisher

class ShopItemsTableViewController: UITableViewController {
    
    @IBOutlet weak var shopSellImage: UIImageView!
    @IBOutlet weak var shopSellName: UILabel!
    @IBOutlet weak var shopSellPrice: UILabel!
    @IBOutlet weak var itemButton: UIButton!
    var click = false
    
    var meals =  [ShopItemFood(name: "超值套餐A(三角薯餅&中杯紅茶)", price: 35),
                  ShopItemFood(name: "超值套餐B(麥克雞塊(4塊)&中杯紅茶)", price: 45),
                  ShopItemFood(name: "超值套餐C(美式雞柳條&中杯紅茶)", price: 55)]
    
    var toppings = [ShopItemFood(name: "加蛋", price: 15),
                   ShopItemFood(name: "加起司", price: 10),
                   ShopItemFood(name: "加培根", price: 10),
                   ShopItemFood(name: "加火腿", price: 10),
                    ShopItemFood(name: "去菜", price: nil),
                    ShopItemFood(name: "去番茄", price: nil),
                    ShopItemFood(name: "去醬", price: nil)]
    
    
    
    
    
    
    
    var shopSellPrice1 = ""
    var shopSellName1 = ""
    var shopSellImage1:UIImage?
    var shopSellUrl:URL?
    
    static var list:DataShopItem?
    var list1 = [DataShopitem]()
    
    override func viewDidLoad() {
        shopSellPrice.text = shopSellPrice1
        shopSellName.text = shopSellName1
        shopSellImage.kf.setImage(with: shopSellUrl)
        
        super.viewDidLoad()

    }
    
    
    
    @IBAction func checkTopping(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point){
            let foodSection =  ShopItemSection(rawValue: indexPath.section)
            let food:ShopItemFood
            switch foodSection{
            case.set:
                if meals[indexPath.row].isadd{
                    meals[indexPath.row].isadd = false
                }
                else{
                    for i in meals.indices{
                        if meals[i].isadd{
                            shopSellPrice1 -= meals[i].price
                        }
                        meals[i].isadd = false
                    }
                    meals[indexPath.row].isadd = true
                }
                food = meals[indexPath.row]
                
            case.topping:
                toppings[indexPath.row].isAdd.toggle()
                food = toppings[indexPath.row]
                
            }
            if food.isadd{
                Int(shopSellPrice1)! += food.price
            }
            else{
                shopSellPrice1 -= food.price
            }
            buttonSum.setTitle("加入購物車+\(shopSellPrice)", for: .normal)
            tableView.reloadData()
        }
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return  meals.count
        }
        else{
            return toppings.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopItemsTableViewCell", for: indexPath) as! ShopItemsTableViewCell
            let food: ShopItemFood
            if indexPath.section == 0 {
                food = meals[indexPath.row]
            }
            else{
                food = toppings[indexPath.row]
            }
            cell.itemsName.text = food.name
            cell.itemsPrice.text = "+\(food.price)"
            cell.itemButton.isSelected = food.isadd
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopItemMoreTableViewCell", for: indexPath) as! ShopItemMoreTableViewCell
            cell.buttonSum.setTitle("加入購物車+\(shopSellPrice)", for: .normal)
            
            
            return cell
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
    
    
//    @IBAction func clickSet(_ sender: UIButton) {
//        let point = sender.convert(CGPoint(x: sender.bounds.midX, y: sender.bounds.midY), to: tableView)
//        if let indexPath = tableView.indexPathForRow(at: point){
//            var meal = list1[indexPath.row]
//            var clickitem = itemButton.isSelected.toggle()
//            list1[indexPath.row] = clickitem
//
//        }
//
//    }
    
}
