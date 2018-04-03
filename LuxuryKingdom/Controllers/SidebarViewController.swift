//
//  SidebarViewController.swift
//  LuxuryKingdom
//
//  Created by Mannindia on 12/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class SidebarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    let menuEntries:[String] = ["Concierge", "Bookings", "VIP Packages", "Leaderboard", "Settings", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.init(named: "LuxuryGold")?.cgColor
        
    }

    @IBAction func showUserProfile(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Profile", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuEntries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        
        let selectionColor:UIView = UIView()
        selectionColor.backgroundColor = UIColor.black
        cell.selectedBackgroundView = selectionColor;
        
        let menuItem = cell.viewWithTag(1) as! UILabel
        menuItem.text = menuEntries[indexPath.row].uppercased()
 
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "Concierge", sender: self)
        case 1:
            self.performSegue(withIdentifier: "Bookings", sender: self)
        case 2:
            self.performSegue(withIdentifier: "VIP", sender: self)
        case 3:
            self.performSegue(withIdentifier: "Leaderboard", sender: self)
        default:
            break
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
