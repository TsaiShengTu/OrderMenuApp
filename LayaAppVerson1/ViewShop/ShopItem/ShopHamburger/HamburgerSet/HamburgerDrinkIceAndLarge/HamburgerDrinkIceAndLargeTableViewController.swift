//
//  HamburgerDrinkIceAndLargeTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/11/10.
//

import UIKit

class HamburgerDrinkIceAndLargeTableViewController: UITableViewController {
    
//    var toppingsAll:[String] = ["冰","中杯"]
    var toppingsDrink:ShopItemSet!
    
    
    //　先為true button就會打勾
    var warmOrColds = [ShopDrinkItem(name: "冰", price: 0, isadd: true),ShopDrinkItem(name: "溫", price: 0)]
    
    var mediumOrBigs = [ShopDrinkItem(name: "中杯", price: 0,isadd: true),ShopDrinkItem(name: "大杯", price: 5)]
    
    var sum = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = toppingsDrink.name
    }
    
    
    
    @IBAction func backHamburger(_ sender: Any) {
        guard let navigationCotroller = self.navigationController else { return }
        let count = navigationCotroller.viewControllers.count
        let gobackList = self.navigationController?.viewControllers[ count - 2] as! shopHambugerTableViewController
            //傳值
        gobackList.toppingsDrink = toppingsDrink
        gobackList.toppingsDrinkShopDrinkItem = mediumOrBigs
        gobackList.priceChanged = sum
        gobackList.isBackFromDrink = true
        
        
        print("有傳了drink喔喔喔",gobackList.toppingsDrink)
        print("priceChange",gobackList.priceChanged)
        navigationCotroller.popToViewController(gobackList, animated: true)
    }
    
    
    @IBAction func addItem(_ sender: UIButton) {
        
            let point = sender.convert(CGPoint.zero, to: tableView)
            if let indexPath = tableView.indexPathForRow(at: point){
                let drinkSection = ShopDrinkItemSection(rawValue: indexPath.section)!
                let drink:ShopDrinkItem
                switch drinkSection{
                case.mediumOrLagre:
//                    if mediumOrBigs[indexPath.row].isadd{
//                        mediumOrBigs[indexPath.row].isadd = false
//                    }
//                    else{
                        for i in mediumOrBigs.indices{
                            if mediumOrBigs[i].isadd{
                                //判斷 點擊
                                sum -= mediumOrBigs[i].price!
                                //檢查有相同名字的東西是第幾個
                                var index1 = 0
                                for (j,indexMeal) in toppingsDrink.choices.enumerated(){
                                    if indexMeal == mediumOrBigs[i].name{
                                        index1 = j
                                    }
                                }
                                //刪除mealsAndtopping當中的第幾個
                                toppingsDrink.choices.remove(at: index1)
                            }
                            //移除後 bool值為false
                            mediumOrBigs[i].isadd = false
                        }
                        //indexPath.row就為true
                        mediumOrBigs[indexPath.row].isadd = true
                        
//                    }
                    drink = mediumOrBigs[indexPath.row]
                case.hotOrcold:
//                    if warmOrColds[indexPath.row].isadd{
//                        warmOrColds[indexPath.row].isadd = false
//                    }
//                    else{
                        for i in warmOrColds.indices{
                            if warmOrColds[i].isadd{
                                //判斷 點擊
                                sum -= warmOrColds[i].price!
                                //檢查有相同名字的東西是第幾個
                                var index1 = 0
                                for (j,indexMeal) in toppingsDrink.choices.enumerated(){
                                    if indexMeal == warmOrColds[i].name{
                                        index1 = j
                                    }
                                }
                                //刪除mealsAndtopping當中的第幾個
                                toppingsDrink.choices.remove(at: index1)
                            }
                            //移除後 bool值為false
                            warmOrColds[i].isadd = false
                        }
                        //indexPath.row就為true
                        warmOrColds[indexPath.row].isadd = true
//                    }
                    drink = warmOrColds[indexPath.row]
                }
                if drink.isadd{
                    //判斷 點擊
                    sum += drink.price!
                    toppingsDrink.choices.append(drink.name)
                }
                else{
                    sum -= drink.price!
                    var index = 0
                    //比對字串的寫法
                    for (i,orderitem) in toppingsDrink.choices.enumerated(){
                        if orderitem == drink.name{
                            index = i
                        }
                    }
                    toppingsDrink.choices.remove(at: index)
                }
                print("mealsAndtopping", toppingsDrink)
                    print(sum)
            }
            tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let drinkSection = ShopDrinkItemSection(rawValue: section)!
        switch drinkSection{
        case.hotOrcold:
            return "飲品溫度"
        case.mediumOrLagre:
            return "容量"
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return warmOrColds.count
        }
        else{
            return mediumOrBigs.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HamburgerDrinkIceAndLargeTableViewCell", for: indexPath) as! HamburgerDrinkIceAndLargeTableViewCell

        let drink:ShopDrinkItem
        if indexPath.section == 0{
            drink = warmOrColds[indexPath.row]
        }
        else{
            drink = mediumOrBigs[indexPath.row]
        }
        cell.itemNameLabel.text = drink.name
        cell.itemPriceLabel.text = String("+$\(drink.price!)")
        cell.itemAddButton.isSelected = drink.isadd

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
