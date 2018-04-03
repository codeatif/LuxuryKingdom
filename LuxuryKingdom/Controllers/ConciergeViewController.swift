//
//  ConciergeViewController.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 19/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class ConciergeViewController: UIViewController {

    @IBOutlet weak var faqButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let customButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = customButton
        
        let callBtn = UIBarButtonItem(image: UIImage(named: "CallIcon"), style: .plain, target: self, action: #selector(callConciergeService))
        self.navigationItem.rightBarButtonItem  = callBtn

        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.init(named: "LuxuryGold") ?? UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "PingFang HK", size: 14)!]
        self.navigationItem.title = "CONCIERGE"
        
        faqButton.layer.cornerRadius = faqButton.frame.size.height/2
        faqButton.layer.borderWidth = 1
        faqButton.layer.borderColor = UIColor(named:"LuxuryGold")?.cgColor
        
        contactButton.layer.cornerRadius = contactButton.frame.size.height/2
        
    }

    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func callConciergeService() {
        
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
