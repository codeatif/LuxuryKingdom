//
//  HomeTableController.swift
//  LuxuryKingdom
//
//  Created by Atif Imran on 12/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class HomeTableController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var servicesCollectionCell: UICollectionView!
    
    var servicesName:[String] = ["PRIVATE JETS", "LUXURY YACHTS", "LUXURY CARS", "CRUISE LINERS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        servicesCollectionCell.register(UINib.init(nibName: "ServicesCell", bundle:nil), forCellWithReuseIdentifier: "ServicesCell")
        if let flowLayout = servicesCollectionCell.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height:1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.init(named: "ContrastWhite") ?? UIColor.brown,
             NSAttributedStringKey.font: UIFont(name: "Snell Roundhand", size: 22)!]
        //Transparent Nav Bar
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        NetworkManager.instance.downloadUserData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 4
//    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ServicesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCell", for: indexPath) as! ServicesCell
        
        cell.serviceName.text = servicesName[indexPath.row]
        let imgView:UIImageView = cell.serviceIcon
        
            if indexPath.row == 0 {
                imgView.image = UIImage(named: "PrivateJet")
            } else if indexPath.row == 1 {
                imgView.image = UIImage(named: "PrivateYacht")
            } else if indexPath.row == 2 {
                imgView.image = UIImage(named: "PrivateCar")
            } else if indexPath.row == 3 {
                imgView.image = UIImage(named: "Cruise")
            }
        
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false;

        imgView.layer.cornerRadius = 5
        imgView.layer.shadowColor = UIColor(named:"ContrastWhite")?.cgColor
        imgView.layer.shadowOpacity = 0.8
        imgView.layer.shadowRadius = 1.0
        imgView.layer.shadowOffset = CGSize(width:0.5, height: 0.5)
        
        let containerView:UIView = cell.viewWithTag(100)!
        containerView.layer.cornerRadius = 5.0
        containerView.layer.borderColor = UIColor(named:"ContrastWhite")?.cgColor
        containerView.layer.borderWidth = 0.2
        containerView.layer.shadowColor = UIColor(named:"ContrastWhite")?.cgColor
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowRadius = 1.0
        containerView.layer.shadowOffset = CGSize(width:0.5, height: 0.5)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            if indexPath.row == 0 {
                self.performSegue(withIdentifier: "Jet", sender: collectionView)
            } else if indexPath.row == 1 {
                self.performSegue(withIdentifier: "Yacht", sender: collectionView)
            } else if indexPath.row == 2 {
                self.performSegue(withIdentifier: "Car", sender: collectionView)
            } else if indexPath.row == 3 {
                self.performSegue(withIdentifier: "Cruise", sender: collectionView)
            }
        
    }
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
