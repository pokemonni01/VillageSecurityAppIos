//
//  HistoryCarTableViewCell.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 27/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit

class HistoryCarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getInLabel: UILabel!
    @IBOutlet weak var guardScanLabel: UILabel!
    @IBOutlet weak var userScanLabel: UILabel!
    @IBOutlet weak var getOutLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
