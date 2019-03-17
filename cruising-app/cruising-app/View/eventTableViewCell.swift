//
//  eventTableViewCell.swift
//  cruising-app
//
//  Created by Peter Luo on 3/17/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import UIKit

class eventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
