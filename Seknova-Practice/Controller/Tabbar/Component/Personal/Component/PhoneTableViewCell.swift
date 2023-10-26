//
//  PhoneTableViewCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/18.
//

import UIKit

class PhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbContent: UILabel!
   
    @IBOutlet weak var imgvVerified: UIImageView!
    
    static let identifier = "PhoneTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
