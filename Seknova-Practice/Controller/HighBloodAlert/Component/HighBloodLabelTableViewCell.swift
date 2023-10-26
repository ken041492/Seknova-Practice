//
//  HighBloodLabelTableViewCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/25.
//

import UIKit

class HighBloodLabelTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbContent: UILabel!
    
    static let identifier = "HighBloodLabelTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
