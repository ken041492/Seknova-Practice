//
//  HaveImageTableViewCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/23.
//

import UIKit

class HaveImageTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var imgvIcon: UIImageView!
    
    static let identifier = "HaveImageTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
