//
//  PickerViewTableViewCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/24.
//

import UIKit

class PickerViewTableViewCell: UITableViewCell {

    @IBOutlet weak var pkvHighLimit: UIPickerView!
   
    static let identifier = "PickerViewTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
