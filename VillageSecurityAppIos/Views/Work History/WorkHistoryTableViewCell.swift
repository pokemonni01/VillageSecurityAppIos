//
//  WorkHistoryTableViewCell.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 12/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit

class WorkHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var side: UILabel!
    @IBOutlet weak var mZone: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
