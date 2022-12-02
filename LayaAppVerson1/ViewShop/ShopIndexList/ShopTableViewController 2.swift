//
//  ShopTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/12.
//

import UIKit

class ShopTableViewController: UITableViewController {
    var list1 = [IndexList]()
    var list2 = [IndexList]()
    
    let laYaIndexpath = IndexPath(row: 3, section: 0)
    
    @IBOutlet weak var closeButtion1: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        list1 = IndexList.loadListData1()
        list2 = IndexList.loadListData2()
        let closeButton2 = UIBarButtonItem(systemItem: .close)
        closeButtion1 = closeButton2
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if tableView.indexPathForSelectedRow == laYaIndexpath
        {
            if let navigationController = navigationController{
                navigationController.popToRootViewController(animated: true)
//                let count = navigationController.viewControllers.count
//                let gobackTop = navigationController.viewControllers[ count - 3]
//                show(gobackTop, sender: nil)
            }
        }
        return indexPath
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
                if unwindSegue.identifier == "ShopTableViewController"{
                    if let indexPath = tableView.indexPathForSelectedRow,let sections = tableView.indexPathForSelectedRow?.section{
                        let goback = unwindSegue.destination as! indexShopTableViewController
                        
                    }
                }
            }
    
    @IBAction func backToShop(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
           return "會員專區"
        }
        else{
           return "門市專區"
        }
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 4
        }
        else{
            return 5
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell", for: indexPath) as! ShopTableViewCell
            let list = list1[indexPath.row]
            cell.shopListName.text = list.listName
            if indexPath.row == 3{
                cell.shopListImage.image = UIImage(named: "LayaLogo")
                }
            else{
                cell.shopListImage.image = UIImage(systemName: list.listImage)
                }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell", for: indexPath) as! ShopTableViewCell
            let list2 = list2[indexPath.row]
            cell.shopListName.text = list2.listName
            cell.shopListImage.image = UIImage(systemName:list2.listImage )
            return cell
        }
        

        // Configure the cell...

        
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
