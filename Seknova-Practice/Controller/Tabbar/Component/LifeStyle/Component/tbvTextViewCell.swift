//
//  tbvTextViewCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/29.
//

import UIKit

class tbvTextViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var tvInput: UITextView!
    
    static let identifier = "tbvTextViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
