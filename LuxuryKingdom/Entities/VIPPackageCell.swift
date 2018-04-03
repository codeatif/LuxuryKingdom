//
//  VIPPackageCell.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 21/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class VIPPackageCell: UICollectionViewCell {
    
    @IBOutlet var serviceIcon: UIImageView!
    @IBOutlet var serviceName: UILabel!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        widthConstraint.constant = UIScreen.main.bounds.size.width
        heightConstraint.constant = UIScreen.main.bounds.size.height/2
    }
}

