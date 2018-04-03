//
//  LeaderboardViewController.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 19/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topUserImage: UIButton!
    @IBOutlet weak var topUserName: UILabel!
    @IBOutlet weak var leadersTableView: UITableView!
    
    let userNames = ["Adam Irresistible", "John Spender", "Kelly Trotter", "Ahmed Prince", "Dave Boy", "Christy Gal", "Sergey Loyal", "Supa Hot Fire", "Christy Gal", "Christy Gal"]
    let spendList = ["$37,000", "$22,910", "$21,010", "$20,910", "$19,110", "$18,000", "$17,330", "$15,130", "$12,000", "$11,205"]
    let imageList = ["top_user.jpg", "man.jpeg", "kelly.jpg","ahmed.jpeg","top_user.jpg","christy.jpeg","top_user.jpg","top_user.jpg","christy.jpeg","christy.jpeg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = customButton
        
        let trophyBtn = UIBarButtonItem(image: UIImage(named: "TrophyIcon"), style: .plain, target: self, action: #selector(trophyBtnTapped))
        self.navigationItem.rightBarButtonItem  = trophyBtn
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.init(named: "LuxuryGold") ?? UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "PingFang HK", size: 14)!]
        self.navigationItem.title = "LEADERBOARD"
        
        topUserImage.layer.borderWidth = 0.8
        topUserImage.layer.borderColor = UIColor(named: "LuxuryGold")?.cgColor
        topUserImage.imageView?.contentMode = UIViewContentMode.scaleAspectFill
    }
    
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func trophyBtnTapped() {
        
    }
    
    @IBAction func showUserProfile(_ sender: UIButton) {
        let vc:ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        (vc.view.viewWithTag(10) as! UIImageView).image = UIImage(named:imageList[0])
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderCell", for: indexPath)
        
        let selectionColor:UIView = UIView()
        selectionColor.backgroundColor = UIColor.black
        cell.selectedBackgroundView = selectionColor;
        
        let userIcon = cell.viewWithTag(1) as! UIImageView
        userIcon.image = UIImage(named:imageList[indexPath.row])
        
        let userName = cell.viewWithTag(2) as! UILabel
        userName.text = userNames[indexPath.row]

        let expenditure = cell.viewWithTag(3) as! UILabel
        expenditure.text = spendList[indexPath.row]

        let rank = cell.viewWithTag(4) as! UILabel
        rank.text = "#\(indexPath.row+1)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc:ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        (vc.view.viewWithTag(10) as! UIImageView).image = UIImage(named:imageList[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
