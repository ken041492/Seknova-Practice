//
//  PersionalMailTableViewCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/16.
//

import UIKit

class PersionalMailTableViewCell: UITableViewCell {

    static let identifier = "PersionalMailTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var mailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
