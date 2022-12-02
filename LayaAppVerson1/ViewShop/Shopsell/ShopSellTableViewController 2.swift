//
//  ShopSellTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/13.
//

import UIKit
import Kingfisher

class ShopSellTableViewController: UITableViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    var Navigationtitle:String = ""
    
    var shoplist = [Recordl]()
    var shoplist1 = [Recordl]()
    var shoplist2 = [Recordl]()
    var shoplist3 = [Recordl]()
    var shoplist4 = [Recordl]()
    var shoplist5 = [Recordl]()
    
//    var shoplistSum = [
//        shoplist1,shoplist2,shoplist3,shoplist4,shoplist5]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = Navigationtitle
        ShopItemController.shared.fetchshopSell { result
            in
            switch result{
            case .success(let respones):
                self.shoplist = respones.records
                for list in self.shoplist{
                    switch list.fields.select{
                    case "美式漢堡":
                        self.shoplist1.append(list)
                    case "飲料":
                        self.shoplist2.append(list)
                    case "米堡":
                        self.shoplist3.append(list)
                    case "超值套餐(附中杯紅茶)":
                        self.shoplist4.append(list)
                    case "輕享套餐(附中杯紅茶)":
                        self.shoplist5.append(list)
                    default:
                        break
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    
                }
            case .failure(_):
                print("error")
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shopItem"{
            if let indexPath = tableView.indexPathForSelectedRow,
               let sections = tableView.indexPathForSelectedRow?.section{
                let goToShopitem = segue.destination as! ShopItemsTableViewController
                switch sections{
                case 0:
                    goToShopitem.shopSellPrice1 = shoplist1[indexPath.row].fields.price
                    goToShopitem.shopSellName1 = shoplist1[indexPath.row].fields.name
                    goToShopitem.shopSellUrl = shoplist1[indexPath.row].fields.image[0].url
                case 1:
                    goToShopitem.shopSellPrice1 = shoplist2[indexPath.row].fields.price
                    goToShopitem.shopSellName1 = shoplist2[indexPath.row].fields.name
                    goToShopitem.shopSellUrl = shoplist2[indexPath.row].fields.image[0].url
                case 2:
                    goToShopitem.shopSellPrice1 = shoplist3[indexPath.row].fields.price
                    goToShopitem.shopSellName1 = shoplist3[indexPath.row].fields.name
                    goToShopitem.shopSellUrl = shoplist3[indexPath.row].fields.image[0].url
                case 3:
                    goToShopitem.shopSellPrice1 = shoplist4[indexPath.row].fields.price
                    goToShopitem.shopSellName1 = shoplist4[indexPath.row].fields.name
                    goToShopitem.shopSellUrl = shoplist4[indexPath.row].fields.image[0].url
                default:
                    goToShopitem.shopSellPrice1 = shoplist5[indexPath.row].fields.price
                    goToShopitem.shopSellName1 = shoplist5[indexPath.row].fields.name
                    goToShopitem.shopSellUrl = shoplist5[indexPath.row].fields.image[0].url
                }
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 :
            return "美式漢堡"
        case 1 :
            return "飲料"
        case 2 :
            return "米堡"
        case 3 :
            return "超值套餐(附中杯紅茶)"
        case 4 :
            return "輕享套餐(附中杯紅茶)"
        default:
            break
        }
        return ""
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return shoplist1.count
        }
        else if  section == 1{
            return shoplist2.count
        }
        else if  section == 2{
            return shoplist3.count
        }
        else if  section == 3{
            return shoplist4.count
        }
        else if  section == 4{
            return shoplist5.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopSellListTableViewCell", for: indexPath) as! ShopSellListTableViewCell
            let lists = shoplist1[indexPath.row]
            cell.shopSellName.text = lists.fields.name
            cell.shopSellPrice.text = lists.fields.price
            cell.shopSellImage.kf.setImage(with: lists.fields.image[0].url)
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopSellListTableViewCell", for: indexPath) as! ShopSellListTableViewCell
            let lists = shoplist2[indexPath.row]
            cell.shopSellName.text = lists.fields.name
            cell.shopSellPrice.text = lists.fields.price
            cell.shopSellImage.kf.setImage(with: lists.fields.image[0].url)
            return cell
        }
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopSellListTableViewCell", for: indexPath) as! ShopSellListTableViewCell
            let lists = shoplist3[indexPath.row]
            cell.shopSellName.text = lists.fields.name
            cell.shopSellPrice.text = lists.fields.price
            cell.shopSellImage.kf.setImage(with: lists.fields.image[0].url)
            return cell
        }
        else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopSellListTableViewCell", for: indexPath) as! ShopSellListTableViewCell
            let lists = shoplist4[indexPath.row]
            cell.shopSellName.text = lists.fields.name
            cell.shopSellPrice.text = lists.fields.price
            cell.shopSellImage.kf.setImage(with: lists.fields.image[0].url)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopSellListTableViewCell", for: indexPath) as! ShopSellListTableViewCell
            let lists = shoplist5[indexPath.row]
            cell.shopSellName.text = lists.fields.name
            cell.shopSellPrice.text = lists.fields.price
            cell.shopSellImage.kf.setImage(with: lists.fields.image[0].url)
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

}
