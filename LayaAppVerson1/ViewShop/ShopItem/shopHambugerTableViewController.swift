//
//  shopHambugerTableViewController.swift
//  LayaAppVerson1
//
//  Created by Sheng-Yu on 2022/10/28.
//

import UIKit

class shopHambugerTableViewController: UITableViewController {
    
    var mealCoures = ShopItemSetPeter.data
    var prepare1:Fieldsl!
    
    @IBOutlet weak var shopSellImage: UIImageView!
    @IBOutlet weak var shopSellName: UILabel!
    @IBOutlet weak var shopSellPrice: UILabel!
    
    @IBOutlet weak var howMuchButton: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var writeSomethingLabel: UILabel!
    @IBOutlet weak var wrtieTextField: UITextField!
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
    
    var sum = 0
    
    var prepare:Fieldsl!
    var shopSellPriceStr = ""
    //要傳的值
    var shopSellNameStr = ""
    
    var shopSellImage1:UIImage?
    var shopSellUrl:URL?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopSellNameStr = prepare1.name
        shopSellNameStr.removeFirst(2)
        if shopSellNameStr.contains("套餐") {
            shopSellNameStr.removeLast(2)
        }
        mealCoures[0].name.append(shopSellNameStr)
        
        shopSellPriceStr = prepare1.price
        shopSellPriceStr.removeFirst()
        print(shopSellPriceStr)
        
        mealCoures[0].price.append(Int(shopSellPriceStr)!)
        print(mealCoures)
        
        
        //計算購物車價錢
        //先傳值過來等於這裡的Label
        shopSellPriceStr = prepare1.price
        //移除$字號
        
        shopSellPrice.text = shopSellPriceStr
        shopSellPriceStr.removeFirst()
        //轉型
        sum = Int(shopSellPriceStr) ?? 0
        print(sum)
        print(shopSellPriceStr)
        howMuchButton.setTitle("加入購物車  $\(sum*numberSum)", for: .normal)
        
        
        //傳值的接取
        shopSellName.text = prepare1.name
        shopSellImage.kf.setImage(with: prepare1.image[0].url)
        
        //footer
        
        writeSomethingLabel.text = "備註"
        numberLabel.text = "\(numberSum)"
        buttonMinus.isEnabled = false
        
        
        
        
    }
    
    @IBAction func buttonAdd(_ sender: UIButton) {
        sender.isSelected.toggle()
        mealCoures[sender.tag].isadd = sender.isSelected
        let item = mealCoures[sender.tag]
        if item.isadd == false{
            
        }
        else{
            
        }
        
    }
    
    
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectIndexPathInSection = tableView.indexPathForSelectedRow {
            if selectIndexPathInSection.section == indexPath.section {
                tableView.deselectRow(at: selectIndexPathInSection, animated: false)
            }
//            mealCoures[indexPath.section] = indexPath.section
            
        }
        return indexPath
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let foodSection = ShopItemSetSection(rawValue: section)!
//        switch foodSection{
//        case.meal:
//            return "主餐"
//        case.drink:
//            return "套餐20元飲料"
//        case.toppingGrade:
//            return "加料升級優惠(現省5元)"
//        }
        return mealCoures[section].category.rawValue
   
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mealCoures.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if section == 0 {
//            return meal.count
//        }
//        else if section == 1 {
//            return drink.count
//        }
//        else {
//            return toppingSet.count
//        }
        return mealCoures[section].name.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopHambugerTableViewCell.reuseIdentifeir , for: indexPath) as! ShopHambugerTableViewCell
        
//        let food:ShopItemSet
//        if indexPath.section == 0{
//            food = meal[indexPath.row]
//        }
//        else if indexPath.section == 1  {
//            food = drink[indexPath.row]
//        }
//        else{
//            food = toppingSet[indexPath.row]
//        }
        let mealCourse = mealCoures[indexPath.section]
        cell.itemName.text = mealCourse.name[indexPath.row]
        cell.itemPrice.text = String("+$\(mealCourse.price[indexPath.row])")
        cell.itemAdd.isSelected = mealCourse.isadd
        cell.itemAdd.tag = indexPath.row
        
    
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
