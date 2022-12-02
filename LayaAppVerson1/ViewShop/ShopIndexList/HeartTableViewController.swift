//
//  HeartTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/11/3.
//

import UIKit

class HeartTableViewController: UITableViewController {
    
    var saveItems = [Fields]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = Fields.loadHeartData(){
            saveItems = items
            tableView.reloadData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return saveItems.count
    }

    @IBAction func backList(_ sender: UIButton) {
        guard let navigationCotroller = self.navigationController else { return }
        let count = navigationCotroller.viewControllers.count
        let gobackList = self.navigationController?.viewControllers[ count - 2] as! ShopTableViewController
            navigationCotroller.popToViewController(gobackList, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeartTableViewCell", for: indexPath) as! HeartTableViewCell
        let item = saveItems[indexPath.row]
        cell.heartNameLabel.text = item.shopName
        cell.heartAddressLabel.text = item.shopAddress
        cell.heartButton.isSelected = item.heart ??  false
        cell.heartImage?.image = UIImage(systemName: "photo")
        cell.heartImage?.image = UIImage(named:"LayaLogo")
        
        
        
//        URLSession.shared.dataTask(with:item.shopImage) { data, response, error in
//            if let error = error {
//               print(error)
//            } else if let data = data,
//                      let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    cell.heartImage.image = image
//                }
//            } else {
//                
//            }
//        }.resume()

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

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            saveItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        Fields.saveHeartData(saveheart: saveItems)
        tableView.reloadData()
        
    }
    

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
