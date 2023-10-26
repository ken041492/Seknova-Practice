//
//  HaveSwitchTableViewCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/23.
//

import UIKit

class HaveSwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var switchChange: UISwitch!
    
    static let identifier = "HaveSwitchTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchChange.isOn = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
