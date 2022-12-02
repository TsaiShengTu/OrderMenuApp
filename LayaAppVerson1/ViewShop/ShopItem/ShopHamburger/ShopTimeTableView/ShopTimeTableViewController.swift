//
//  ShopTimeTableViewController.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/11/9.
//

import UIKit
import CoreLocation
import MapKit

class ShopTimeTableViewController: UITableViewController {
    
    var shopTimeNext:Fields!
    
    @IBOutlet weak var addressButton: UIButton!
    
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var appCodeNumberLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var takeInLabel: UILabel!
    @IBOutlet weak var takeOutLabel: UILabel!
    
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latitude = Double(shopTimeNext.latitude) ?? 0
        longitude = Double(shopTimeNext.longitude) ?? 0
        
        let shopTime = shopTimeNext.shopTakeInTime.components(separatedBy: "/")

        appCodeNumberLabel.text = shopTimeNext.shopAppCode
        openTimeLabel.text = shopTimeNext.shopTime
        takeOutLabel.text = shopTimeNext.shopTime
        
        if shopTime.count == 3 {
            takeInLabel.text = "\(shopTime[0])\n\(shopTime[1] )\n\(shopTime[2])"
        }
        else {
            takeInLabel.text = shopTimeNext.shopTakeInTime
        }
        
        phoneNumberButton.setTitle(shopTimeNext.phoneNumber, for: .normal)
        addressButton.setTitle(shopTimeNext.shopAddress, for: .normal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendButtonTapped))
        
        
        
    }
    
    
    @IBAction func call(_ sender: Any) {
        if let url = URL(string: "tel://\(shopTimeNext.phoneNumber)"){
            UIApplication.shared.open(url)
            print("call",url)
        }
    }
    
    @IBAction func goToMap(_ sender: UIButton) {
        //地標
        let toPlacemark = CLLocationCoordinate2D(latitude:latitude, longitude:longitude)
        
        //大頭針
        let toPin = MKPlacemark(coordinate: toPlacemark)
        
        //終點
        let destMapItem = MKMapItem(placemark: toPin)
        let userMapItem = MKMapItem.forCurrentLocation()
        
        //座標陣列
        let routes = [userMapItem,destMapItem]
        
        let option = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMaps(with: routes, launchOptions: option)
    }
    
    
    @objc func recommendButtonTapped(){
        let vc = UIActivityViewController(activityItems: ["Recommend this shop to your friends"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc,animated: true)
    }
    
    
    
    // MARK: - Table view data source

    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
