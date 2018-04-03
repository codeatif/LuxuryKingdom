//
//  JetViewController.swift
//  LuxuryKingdom
//
//  Created by Atif Imran on 12/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class JetViewController: UITableViewController {

    var carsList:[[String:Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let customButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = customButton
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .plain, target: self, action: #selector(searchButtonTapped))
        self.navigationItem.rightBarButtonItem  = searchButton
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.init(named: "LuxuryGold") ?? UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "PingFang HK", size: 14)!]
        self.navigationItem.title = "PRIVATE JETS"
        
        for i in 1..<6{
            var carsData:[String:Any] = [:]
            carsData["image"] = "Car\(i)"
            carsData["name"] = "Lamborghini Avantador"
            carsData["price"] = "1000"
            carsData["currency"] = "AED"
            carsData["capacity"] = "12"
            carsData["availability"] = "1"
            carsData["rental_duration_in_hrs"] = "8"
            carsData["location"] = "Dubai"
            carsList.append(carsData)
        }
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
        image.image = UIImage.init(named:(carsList[indexPath.row])["image"] as! String)
        
        let name = cell.viewWithTag(2) as! UILabel
        name.layer.cornerRadius = name.frame.size.height/2
        name.text = "\((carsList[indexPath.row])["name"] as! String)"
        
        let price = cell.viewWithTag(3) as! UILabel
        price.layer.cornerRadius = price.frame.size.height/2
        price.text = "\((carsList[indexPath.row])["currency"] as! String) \((carsList[indexPath.row])["price"] as! String)"
        
        return cell
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
