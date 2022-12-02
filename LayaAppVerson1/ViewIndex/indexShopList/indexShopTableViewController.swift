//
//  indexShopTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/12.
//

import UIKit
import Kingfisher

class indexShopTableViewController: UITableViewController {
    
    //ActivityIndicator 下載資料
    let loadingView = UIView()
    //下載的圈圈
    let activityIndicator = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    
    
    
    //把下載的東西接給這個變數
    
    var lists = [Record]()
    
    
    //要把資料丟進去的 陣列
    var shopsAll = [Fields]()
    
    //字典，用來存放 用字串分類的 陣列
    var shoplistDic = [String:[Fields]]()
    //分類
    var group = [String]()
    
    //要儲存的資料
    var savehearts = [Fields]()
    
    //全部的資料
//    var itemhearts = [Fields]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        setActivityIndicatorView()
        self.showActivityIndicatorView()
        
        ShopItemController.shared.fetchshopList { [self] result
            in
             switch result {
             case .success(let respone):
                 //呼叫 抓取DataShopitem型別
                 let list:DataShopitem! = respone
                 self.shopsAll = []
                 //迴圈抓取下載的東西
                 for i in list.records.indices{
                     let shop = Fields(shopName: list.records[i].fields.shopName, shopAddress: list.records[i].fields.shopAddress, shopCity: list.records[i].fields.shopCity,shopImage: list.records[i].fields.shopImage, phoneNumber: list.records[i].fields.phoneNumber,shopTime: list.records[i].fields.shopTime,shopAppCode: list.records[i].fields.shopAppCode,shopTakeInTime: list.records[i].fields.shopTakeInTime,latitude: list.records[i].fields.latitude,longitude: list.records[i].fields.longitude )
                     //一筆筆加入 本地的資料陣列
                     self.shopsAll.append(shop)
                 }
                 DispatchQueue.main.async {                            
                     if let items = Fields.loadHeartData(){
                         self.savehearts = items
                         self.updateSaveHeart()
                         print(Fields.documentDirectory)
                     }
                     //把字典用 本地資料裡的shopCity分類
                     self.shoplistDic = Dictionary(grouping: self.shopsAll) { shop in
                         shop.shopCity
                     }
                     //　分類
                     self.group = self.shoplistDic.keys.sorted()

                     self.tableView.reloadData()
                     self.hideActivityIndicatorView()
                     
                 }
             case .failure(_):
                 print("error")
            }
        }
    }
    
    // 檢查表格 heart是否相等，檢查cell重複利用的問題
     func updateSaveHeart(){
        // indices 是迴圈的總數
        for i in shopsAll.indices{
            
            //檢查savehearts 中的東西 是否有個 itemhearts相等
            let saveheart = savehearts.first { item in
                item.shopName == shopsAll[i].shopName
            }
            //如果找不到的話
            if saveheart == nil {
                shopsAll[i].heart = false
            }
            //如果找到
            else{
                shopsAll[i].heart = true
            }
        }
        self.tableView.reloadData()
        print(shopsAll)
    }
    
    
    @IBAction func saveHeart(_ sender: UIButton) {
        sender.isSelected.toggle()
        let point = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath1 = tableView.indexPathForRow(at: point) {
            
            let group = group[indexPath1.section]
            //用group分類出的資料 分給shopsAll
            shopsAll = shoplistDic[group]!
            shopsAll[indexPath1.row].heart = sender.isSelected
            //每個row的資料
            let item = shopsAll[indexPath1.row]
            
            if item.heart == true{
                savehearts.append(item)
                print("1",savehearts)
            }
            else{
                //比對字串
                let index = savehearts.firstIndex { Fields in
                    Fields.shopName == item.shopName
                }
                if let index{
                    //刪除
                    savehearts.remove(at: index)
                    print("3",savehearts)
                }
            }
            Fields.saveHeartData(saveheart: savehearts)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "indexShopTableViewCell"{
            
            //
            if let row = tableView.indexPathForSelectedRow?.row, let section = tableView.indexPathForSelectedRow?.section{
                print("section",section)
                print("row",row)
                let prepareText = segue.destination as! ShopSellTableViewController
                switch section{
                case 0:
                    prepareText.shop = shoplistDic["台北"]![row]
                    prepareText.shopsAll = shopsAll
                    prepareText.savehearts = savehearts
                case 1:
                    prepareText.shop = shoplistDic["基隆"]![row]
                    prepareText.shopsAll = shopsAll
                    prepareText.savehearts = savehearts
                case 2:
                    prepareText.shop = shoplistDic["新北"]![row]
                    prepareText.shopsAll = shopsAll
                    prepareText.savehearts = savehearts
                default:
                    break
                }
                
            }
        }
    }
    
    //登出
    @IBAction func logout(_ sender: Any) {
        let alertController = UIAlertController(title: "確定要登出嗎？", message: "確定喔？", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            UserDefaults.standard.removeObject(forKey: "Token")
            //回到第一頁 等於初始化root的頁面
            self.view.window?.rootViewController = self.storyboard?.instantiateInitialViewController()
        }
        let actionCancel = UIAlertAction(title: "取消", style: .default)
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        present(alertController, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  group[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return group.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let group = group[section]
        let shops = shoplistDic[group]
        
        return shops?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "indexShopTableViewCell", for: indexPath) as! indexShopTableViewCell
        
//        let shoplists:collectionShop
//        if indexPath.section == 0 {
//            shoplists = shoplist[indexPath.row]
//        }
//        else{
//            shoplists = shoplistTapie[indexPath.row]
//        }
        //group的資料
        let group = group[indexPath.section]
        
        //用group分類出的資料
        let shops = shoplistDic[group]!
        
        //用group分類的indexPath.row
        let shop = shops[indexPath.row]
        
        
        cell.shopImage.kf.setImage(with: shop.shopImage[0].url)
        cell.shopNameLable.text = shop.shopName
        cell.shopAddressLable.text = shop.shopAddress
        cell.heartButton.isSelected = shop.heart ?? false
        
        //tag是計算indexPath.row的位置
//        cell.heartButton.tag = indexPath.row
        
        
        
        
        //        let shopList = indexShopTableViewController.list?.records[indexPath.row]
        //        cell.shopNameLable.text = shopList?.fields.shopName
        //        cell.shopAddressLable.text = shopList?.fields.shopAddress
        //        cell.shopImage.kf.setImage(with:shopList?.fields.shopImage[0].url)
        
        // Configure the cell...
        
        return cell
    }
    
    
//    @IBAction func collectionHeart(_ sender: UIButton) {
//        //被點擊的點
//        let point = sender.convert(CGPoint(x: sender.bounds.midX, y: sender.bounds.midY), to: tableView)
//        //點擊的表格
//        if let indexPath = tableView.indexPathForRow(at: point){
//            let list:collectionShop
//            let shopCity =  CollectionShopCity(rawValue: indexPath.section)!
//            switch shopCity{
//            case.jilong:
//                shoplist[indexPath.row].heart.toggle()
//                
//            case.tapie:
//                shoplistTapie[indexPath.row].heart.toggle()
//            }
//            if list.heart{
//                //判斷 點擊
//                shopAll.append(list)
//                print(shopAll)
//            }
//            else{
//                var index = 0
//                //比對字串的寫法
////                for (i,orderitem) in shopAll.enumerated(){
////                    if orderitem == list.shopName{
////                        index = i
////                    }
////                }
//                shopAll.remove(at: index)
//            }
//
//            
//        }
//    }
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

extension indexShopTableViewController{
    func setActivityIndicatorView(){
        //設定物件View的寬高
        let width:CGFloat = 120
        let height:CGFloat = 30
        
        //計算位置 tableView width - 物件的寬
        let x = (tableView.frame.width/2) - (width/2)
        //計算位置 tableView height - 物件的高 - navigationBar的高
        let y = (tableView.frame.height/3) - (height/2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        //設定文字條
        loadingLabel.textColor = .lightGray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "跑跑跑..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        
        //設定物件型態
        activityIndicator.style = .medium
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicator.startAnimating()
        
        loadingView.addSubview(loadingLabel)
        loadingView.addSubview(activityIndicator)
        tableView.addSubview(loadingView)
    }
        func showActivityIndicatorView() { loadingView.isHidden = false}
        
        func hideActivityIndicatorView() { loadingView.isHidden = true}
        
}
