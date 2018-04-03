//
//  ServiceCell.swift
//  LendMePay
//
//  Created by Atif Imran on 1/17/18.
//  Copyright © 2018 Atif Imran. All rights reserved.
//

import UIKit

class ServicesCell: UICollectionViewCell {
    
    @IBOutlet var serviceIcon: UIImageView!
    @IBOutlet var serviceName: UILabel!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        widthConstraint?.constant = UIScreen.main.bounds.size.width - 30

    }
    
}
