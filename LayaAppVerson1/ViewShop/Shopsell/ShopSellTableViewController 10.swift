//
//  ShopSellTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/13.
//

import UIKit
import Kingfisher

class ShopSellTableViewController: UITableViewController {
    
    
    
    @IBOutlet var searchBar: UITableView!
    //ActivityIndicator 下載資料
    let loadingView = UIView()
    //下載的圈圈
    let activityIndicator = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    
    
    //上一頁的單筆資料
    
    var shop:Fields!
    
    
    @IBOutlet weak var heartButton: UIBarButtonItem!
    var touchedStarIndex = 0
//    var list : collectionShopes?
    
    //接取傳值過來的店家名稱和地址等
    var collectionShopGet:collectionShop!
    
//    //新增表格的orderMenu
//    var collectionSum = [collectionShopes]()
//    //單筆資料，每次都會新增一個results
//    var collectionLists: collectionShopes!
    
     //為了引用函式
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    var navigationtitle:String = ""
    
    var shoplist = [Recordl]()
    var shoplist1 = [Recordl]()
    var shoplist2 = [Recordl]()
    var shoplist3 = [Recordl]()
    var shoplist4 = [Recordl]()
    var shoplist5 = [Recordl]()
    
    //依搜尋結果篩選出來的資料，沒篩選就是全部的資料
    var currentMenu = [Fieldsl]()
    
    //未分類的全部資料
    var shopSellAll = [Fieldsl]()
    
    var shopSellDic = [String:[Fieldsl]]()
    
    var group = [String]()
    
    //分類好裝好的資料
    var shopSellOk = [Fieldsl]()
    
    //searchBar switch
    var index = 0
    

    override func viewDidLoad() {
        searchBar.delegate = self
        super.viewDidLoad()
        setActivityIndicatorView()
        self.showActivityIndicatorView()
        
        navigationtitle = shop.shopName
        
        navigationBar.title = navigationtitle
        ShopItemController.shared.fetchshopSell { result
            in
            switch result{
            case .success(let respones):
                let shopSell:DataShopSell! = respones
                for i in shopSell.records.indices{
                    let sell = Fieldsl(name: shopSell.records[i].fields.name, price: shopSell.records[i].fields.price, select: shopSell.records[i].fields.select, sale: shopSell.records[i].fields.sale, image: shopSell.records[i].fields.image)
                    self.shopSellAll.append(sell)
                }
                // 把抓來的東西 給currentMenu ，也就是當前目錄
                self.currentMenu = self.shopSellAll
                //分類
                self.classifyShopSell()
            case .failure(_):
                print("error")
            }
        }
        
        
        

//        heartButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal, barMetrics:.default)
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //分類資料的函式
    func classifyShopSell(){
        self.shopSellDic = Dictionary(grouping: self.currentMenu) { shop in
            shop.select
        }
        self.group = self.shopSellDic.keys.sorted()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideActivityIndicatorView()
            }
    }
    
    
    
    func fetchMenu(searchItem:String){
        if searchItem.isEmpty{
            // 把抓來的東西 給currentMenu ，也就是當前目錄
            currentMenu = shopSellAll
            print("current",currentMenu)
        }
        else{
            // 把篩選的東西 給currentMenu ，也就是當前目錄
            currentMenu = shopSellAll.filter({ $0.name.contains(searchItem)
            })
            print("currentSearchName",currentMenu)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
            
        }
        //分類並更新
        classifyShopSell()
    }
    
    
    
    
    //收藏的函式
//    @IBAction func collectionHeart(_ sender: UIBarButtonItem) {
//        if list?.collectedVocs.contains(collectionShopGet) == false {
//            //如果比對過後，沒有東西
//            //加入到AllVocs
//            list?.collectShop(isCollected: true, allCollect:collectionShopGet )
//            heartButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal, barMetrics: .default)
//            print("YoYo")
//            //加入所有牌組
//        } else {
//            //反之，不加入牌組
//            list?.collectShop(isCollected: false, allCollect: collectionShopGet)
//            heartButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal, barMetrics:.default)
//            print("YoYo1")
//        }
//        list?.save(item:[collectionShopGet])
//        print(list?.save(item:[collectionShopGet]))
//
//        //重置
//        tableView.reloadData()
//
//    }
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = group[indexPath.section]
        
        shopSellOk = shopSellDic[group]!
        
        let shopSell = shopSellOk[indexPath.row]
        switch group {
        case "米堡":
            performSegue(withIdentifier: "美式漢堡", sender: nil)
        case "輕享套餐(附中杯紅茶)":
            performSegue(withIdentifier: "超值套餐(附中杯紅茶)", sender: nil)
        default:
            performSegue(withIdentifier: shopSell.select, sender: nil)
        }
        
        
    }
    
    @IBSegueAction func showUShambuger(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ShopItemsTableViewController? {
        let controller = ShopItemsTableViewController(coder: coder)
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.prepare = shopSellOk[row]
        }
        return controller
    }
    
    
    
    @IBSegueAction func showSet(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> shopHambugerTableViewController? {
        let controller =  shopHambugerTableViewController(coder: coder)
        if let row = tableView.indexPathForSelectedRow?.row{
            controller?.prepareHamburgerAction = shopSellOk[row]
        }
        return controller
    }
    
    
    @IBSegueAction func showDrink(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> DrinkTableViewController? {
        // 用個變數接起來,代表能到 那個頁面東西
        let controller = DrinkTableViewController(coder: coder)
        if let row = tableView.indexPathForSelectedRow?.row{
            controller?.prepareDrink = shopSellOk[row]
        }
        return controller
    }
    
    
    // MARK: - Table view data source
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "\(group)"{
            if let indexPath = tableView.indexPathForSelectedRow,
               let sections = tableView.indexPathForSelectedRow?.section{
                let goToShopitem = segue.destination as! ShopItemsTableViewController
                
                
                
                
                
//                default:
//                    goToShopitem.shopSellPrice1 = shoplist5[indexPath.row].fields.price
//                    goToShopitem.shopSellName1 = shoplist5[indexPath.row].fields.name
//                    goToShopitem.shopSellUrl = shoplist5[indexPath.row].fields.image[0].url
                
            }
        }
        
    }
    
    
    
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
        let dic = shopSellDic[group]
        
        return dic?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopSellListTableViewCell", for: indexPath) as! ShopSellListTableViewCell
            //            let lists = shoplist1[indexPath.row]
            //            cell.shopSellName.text = lists.fields.name
            //            cell.shopSellPrice.text = lists.fields.price
            //            cell.shopSellImage.kf.setImage(with: lists.fields.image[0].url)
            //            return cell
            //        }
            
            let group = group[indexPath.section]
            
            shopSellOk = shopSellDic[group]!
            
            let shopSell = shopSellOk[indexPath.row]
            cell.shopSellName.text = shopSell.name
            cell.shopSellPrice.text = shopSell.price
            cell.shopSellImage.kf.setImage(with: shopSell.image[0].url)
            
            
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

extension ShopSellTableViewController{
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

extension ShopSellTableViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchItem = searchBar.text ?? ""
        fetchMenu(searchItem: searchItem)
    }
    func searchBarSearchMenu(_ searchBar:UISearchBar){
        searchBar.resignFirstResponder()
    }
}
