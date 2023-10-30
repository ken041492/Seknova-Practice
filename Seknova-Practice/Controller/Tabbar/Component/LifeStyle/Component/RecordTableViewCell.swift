//
//  RecordTableViewCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/27.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var imgvIcon: UIImageView!
    
    
    static let identifier = "RecordTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
