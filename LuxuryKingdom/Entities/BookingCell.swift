//
//  BookingCell.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 21/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class BookingCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var rating: UIStackView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
