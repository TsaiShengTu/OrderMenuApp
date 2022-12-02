//
//  OrderListTableViewController.swift
//  LayaAppVerson1
//
//  Created by Sheng-Yu on 2022/10/19.
//

import UIKit

class OrderListTableViewController: UITableViewController {
    
    @IBOutlet weak var howToPay: UIButton!
    @IBOutlet weak var buttonGotoshop: UIButton!
    
    
    //接收的orderMenu
    var orderListGet:orderMenu!
    
    //新增表格的orderMenu
    //全部訂單
    var orderSum = [orderMenu]()
    //單筆資料，每次都會新增一個results
//    var orderLists: SaveOrderMenu!
    
    
    //unwind
    var order:orderMenu?
    // hamburger unwind
    var orderHamburger:orderMenu?
    // drink unwind
    var orderDrink:orderMenu?
    
    //上傳的資料
    var orderList = [OrderListItem]()
    
    var orderSumPrice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        //下載
//        orderLists = SaveOrderMenu(results: [orderListGet])
//        orderSum.append(orderListGet)
        //下載
        orderSum = orderMenu.loadOrderList() ?? []
        //儲存
        orderSum.append(orderListGet)
        updateOrderSum()
        
        howToPay.setTitle("送出訂單", for: .normal)
//        orderMenu.saveOrderList(orderList: orderSum)
        
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    
    func updateOrderSum(){
        //每次更新的時候都做一次計算
        orderSumPrice = 0
        //迴圈取出每筆訂單的價錢
        for sum in orderSum {
            orderSumPrice += sum.priceSume
        }
        buttonGotoshop.setTitle("繼續點餐\n  $ \(orderSumPrice)", for: .normal)
    }
    
    
    //返回頁面
    @IBAction func goBackShop(_ sender: UIButton) {
        //判斷有無navigationController
        if let navigationController = navigationController{
            //計算viewControllers數量
                let count = navigationController.viewControllers.count
            //第二頁是-3 要記得轉型到想去的頁面
                let gobackTop = navigationController.viewControllers[ count - 3] as! ShopSellTableViewController
            //present 去 pop回
            //show 去 diss回
            navigationController.popToViewController(gobackTop, animated: true)
            orderMenu.saveOrderList(orderList:orderSum)
            print(orderMenu.documentsDirectory)
        }
        
//        print(SaveOrderMenu.saveOrderList)
//        print(SaveOrderMenu.documentsDirectory)
        
    }
    
    @IBAction func updateItemList(_ sender: Any) {
        if orderSum.count == 0 {
            let title = "請選擇商品🤤"
            let message = "拉雅最棒"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
        else{
            let title = "訂購成功"
            let message = "吃起來🤤"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
                self.uploadOrder()
            }))
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    func uploadOrder(){
        let shopListUrl = URL(string: "https://api.airtable.com/v0/appk1fzVKpuilyG7v/orderList")!
        var request = URLRequest(url: shopListUrl)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        //要記得加json的解析格式
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        
        //呼叫上傳資料型別的陣列
        var recrords = [Record4]()
        
        //把訂單迴圈加入 上傳資料型別
        for items in orderSum{
            
            let list = Record4(fields: Fields4(itemName: items.itemName, priceSum: items.priceSume, toppingAndMeals: items.toppingAndMeals, textField: items.textField, itemNumber: items.itemNumber,toppingAll: items.toppingAll))
                recrords.append(list)
        }
        
        //把資料裝上 上傳資料型別．進行解碼
        let orderlist = OrderListItem(records: recrords)
        
        request.httpBody = try? encoder.encode(orderlist)
        
        print(String(data: request.httpBody!, encoding: .utf8)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error
            in
            if data != nil{
                
                print(request)
                
                DispatchQueue.main.async {
                    
                    guard let navigationCotroller = self.navigationController else { return }
                    let count = navigationCotroller.viewControllers.count
                    let gobackTop = self.navigationController?.viewControllers[ count - 3] as! ShopSellTableViewController
                        navigationCotroller.popToViewController(gobackTop, animated: true)
                    
                    //報錯可以使用 string(data,encoding)
                    let content = String(data: data!, encoding: .utf8)
                }
            }
        }.resume()
        
        orderSum.removeAll()
        orderMenu.saveOrderList(orderList:orderSum)
        tableView.reloadData()
        
    }
    
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderSum.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        let order = orderSum[indexPath.row]
        cell.itemName.text = order.itemName
        cell.itemTopping.text = order.toppingAndMeals.description
        cell.itemWriteSomething.text = order.textField
        cell.itemPrice.text = String("$\(order.priceSume)")
        cell.itemNumber.text = String(order.itemNumber)
        
        if order.toppingAndMeals.isEmpty {
            cell.itemTopping.isHidden = true
        }
        else{
            cell.itemTopping.text = order.toppingAndMeals.description
        }
        
        if order.toppingAll.isEmpty {
            cell.ItemToppingAllLabel.isHidden = true
        }
        else{
            cell.ItemToppingAllLabel.text = order.toppingAll.description
        }
        
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
            orderSum.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        orderMenu.saveOrderList(orderList:orderSum)
        updateOrderSum()
        tableView.reloadData()

    }
    
    //回傳資料
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "orderList" else{ return }
        
        if orderListGet != nil{
            order  = orderListGet
        }
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
