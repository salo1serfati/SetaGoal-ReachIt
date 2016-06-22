//
//  GoalTableViewCell.swift
//  Set a Goal - Reach It
//
//  Created by Salomon serfati on 6/21/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ppdLabel: UILabel!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
