//
//  cvTypeCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/28.
//

import UIKit

class cvTypeCell: UICollectionViewCell {

    @IBOutlet weak var imgvIcon: UIImageView!
    
    @IBOutlet weak var lbTitle: UILabel!
   
    static let identifier = "cvTypeCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
