//
//  indexShopTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/12.
//

import UIKit
import Kingfisher

class indexShopTableViewController: UITableViewController {

    static var list: DataShopitem?
    
    //把下載的東西接給這個變數
    var lists = [Record]()
    //項目的數項
    var city1 = [Record]()
    
    var heartClick = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShopItemController.shared.fetchshopList { result
            in
             switch result {
             case .success(let respone):
                 indexShopTableViewController.list = respone
                 DispatchQueue.main.async {
                     //讀出全部的東西
                     self.lists = respone.records
                     for list in self.lists{
                         switch list.fields.shopCity{
                         case "基隆":
                             self.city1.append(list)
                         default:
                             break
                         }
                     }
                     self.tableView.reloadData()
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "indexShopTableViewCell"{
            if let indexPath = tableView.indexPathForSelectedRow, let sections = tableView.indexPathForSelectedRow?.section{
                let prepareText = segue.destination as! ShopSellTableViewController
                switch sections {
                case 0:
                    prepareText.Navigationtitle = city1[indexPath.row].fields.shopName
                    let selectShop = collectionShop(address: city1[indexPath.row].fields.shopAddress, shopName: city1[indexPath.row].fields.shopName, pic: city1[indexPath.row].fields.shopImage[0].url, heart: heartClick)
                    prepareText.collectionShopGet = selectShop
                default:
                    break
                }
                
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "基隆"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return city1.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "indexShopTableViewCell", for: indexPath) as! indexShopTableViewCell
        
        let shopList = indexShopTableViewController.list?.records[indexPath.row]
        cell.shopNameLable.text = shopList?.fields.shopName
        cell.shopAddressLable.text = shopList?.fields.shopAddress
        cell.shopImage.kf.setImage(with:shopList?.fields.shopImage[0].url)

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
