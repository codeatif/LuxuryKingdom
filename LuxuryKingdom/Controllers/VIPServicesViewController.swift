//
//  VIPServicesViewController.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 21/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class VIPServicesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var serviceTitle: UILabel!
    
    var servicesName:[String] = ["BIRTHDAY BASH", "PARTNER SURPRISE", "HOLIDAY BLAST", "WEEKENDER", "ROYAL TREAT", "ELITE SUITE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        servicesCollectionView.register(UINib.init(nibName: "VIPPackageCell", bundle:nil), forCellWithReuseIdentifier: "VIPPackageCell")
        if let flowLayout = servicesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height:1)
        }
        
        let customButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = customButton
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .plain, target: self, action: #selector(searchButtonTapped))
        self.navigationItem.rightBarButtonItem  = searchButton
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.init(named: "LuxuryGold") ?? UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "PingFang HK", size: 14)!]
        self.navigationItem.title = "VIP PACKAGES"
        
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex:NSInteger = NSInteger(servicesCollectionView.contentOffset.x / servicesCollectionView.frame.size.width)
        serviceTitle.text = servicesName[currentIndex]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:VIPPackageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VIPPackageCell", for: indexPath) as! VIPPackageCell
        
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
        
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
