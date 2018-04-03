//
//  BookingsTableViewController.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 21/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class BookingsTableViewController: UITableViewController {

    var imageList:[String] = ["alexandra_exterior_53722_web.jpeg", "o-mega_exterior_56030_web.jpeg", "quantum_exterior_55399_web.jpeg", "ypi_yacht_charter_mary_jean_II_exterior_hero.jpg", "ypi_yacht_sale_rl_noor_exterior_hero.jpg", "alexandra_exterior_53722_web.jpeg", "o-mega_exterior_56030_web.jpeg", "quantum_exterior_55399_web.jpeg", "ypi_yacht_charter_mary_jean_II_exterior_hero.jpg", "ypi_yacht_sale_rl_noor_exterior_hero.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let customButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = customButton
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .plain, target: self, action: #selector(searchButtonTapped))
        self.navigationItem.rightBarButtonItem  = searchButton
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.init(named: "LuxuryGold") ?? UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "PingFang HK", size: 14)!]
        self.navigationItem.title = "BOOKINGS"
    }

    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func searchButtonTapped() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BookingCell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        
        let day = generateRandomDate(daysBack: Int(arc4random_uniform(100)) )
        cell.date.text = day.0
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        cell.amount.text = formatter.string(from: (1000 + Int(arc4random_uniform(UInt32(8001)))) as NSNumber )
        
        cell.id.text = "Booking Ref: \(random(length: 8))"
        cell.location.text = "Al Waleed Dock, Dubai"
        cell.title.text = "Yacht trip on \(day.1)"
        cell.backgroundImage.image = UIImage(named:imageList[indexPath.row])
        cell.backgroundImage.layer.cornerRadius = 5
        
        cell.backgroundImage.layer.cornerRadius = 5.0
        cell.backgroundImage.layer.borderColor = UIColor.lightGray.cgColor
        cell.backgroundImage.layer.borderWidth = 0.6
        cell.backgroundImage.layer.shadowColor = UIColor.lightGray.cgColor
        cell.backgroundImage.layer.shadowOpacity = 0.8
        cell.backgroundImage.layer.shadowRadius = 1.0
        cell.backgroundImage.layer.shadowOffset = CGSize(width:0.5, height: 0.5)
        
        return cell
    }
 
    func random(length: Int = 20) -> String {
        let base = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    
    func generateRandomDate(daysBack: Int)-> (String, String){
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: randomDate!)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd MMM, yyyy"
        let dateStr = formatter.string(from: yourDate!)
        formatter.dateFormat = "EEEE"
        let dayStr = formatter.string(from: yourDate!).capitalized
        return (dateStr, dayStr)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
