//
//  txfLbCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/30.
//

import UIKit

class txfLbCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbUnit: UILabel!
    
    @IBOutlet weak var txfInput: UITextField!
    
    static let identifier = "txfLbCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
