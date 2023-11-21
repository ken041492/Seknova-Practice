//
//  PersonalInfoTableViewCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/16.
//

import UIKit

class PersonalInfoTableViewCell: UITableViewCell {

    static let identifier = "PersonalInfoTableViewCell"
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var txfInput: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txfInput.placeholder = NSLocalizedString("Click to edit", comment: "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
