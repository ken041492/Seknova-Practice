//
//  PersionalBirthTableViewCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/16.
//

import UIKit

class PersionalBirthTableViewCell: UITableViewCell {

    static let identifier = "PersionalBirthTableViewCell"
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbSelect: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
