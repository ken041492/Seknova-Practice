//
//  eventRecordCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/11/1.
//

import UIKit

class eventRecordCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbTime: UILabel!
    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var lbNameTitle: UILabel!
    
    @IBOutlet weak var lbQuantityTitle: UILabel!
    
    @IBOutlet weak var lbMarkTitle: UILabel!
    
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var lbQuantity: UILabel!
    
    @IBOutlet weak var lbMark: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAction.imageView?.contentMode = .scaleAspectFit
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
