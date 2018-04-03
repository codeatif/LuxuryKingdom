//
//  YachtViewController.swift
//  LuxuryKingdom
//
//  Created by Mannindia on 12/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class YachtViewController: UITableViewController {

    var nameList:[String] = ["Alexandra", "o-mega", "Quantom", "mary jean", "rl noor"]
    var sizeList:[String] = ["120 FT", "164 FT", "187 FT", "234 FT", "210 FT"]
    var imageList:[String] = ["alexandra_exterior_53722_web.jpeg", "o-mega_exterior_56030_web.jpeg", "quantum_exterior_55399_web.jpeg", "ypi_yacht_charter_mary_jean_II_exterior_hero.jpg", "ypi_yacht_sale_rl_noor_exterior_hero.jpg"]
    var priceList:[String] = ["AED 1600 / HR", "AED 2300 / HR", "AED 1300 / HR", "AED 4650 / HR", "AED 10000 / HR"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let customButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = customButton
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .plain, target: self, action: #selector(searchButtonTapped))
        self.navigationItem.rightBarButtonItem  = searchButton
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.init(named: "LuxuryGold") ?? UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "PingFang HK", size: 14)!]
        self.navigationItem.title = "YACHTS"
        
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath)
        
        let image = cell.viewWithTag(1) as! UIImageView
        image.image = UIImage.init(named:imageList[indexPath.row])
        
        let name = cell.viewWithTag(2) as! UILabel
        name.text = nameList[indexPath.row].uppercased()
        
        let size = cell.viewWithTag(3) as! UILabel
        size.text = sizeList[indexPath.row].uppercased()
        
        let price = cell.viewWithTag(7) as! UILabel
        price.layer.cornerRadius = price.frame.size.height/2
        price.text = priceList[indexPath.row].uppercased()


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:ServiceDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "Details") as! ServiceDetailsViewController
        let title = vc.view.viewWithTag(2) as! UILabel
        title.text = nameList[indexPath.row].uppercased()
        
        let img = vc.view.viewWithTag(1) as! UIImageView
        img.image = UIImage.init(named:imageList[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
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
