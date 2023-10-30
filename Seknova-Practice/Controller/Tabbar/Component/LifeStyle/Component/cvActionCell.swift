//
//  cvActionCell.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/28.
//

import UIKit

class cvActionCell: UICollectionViewCell {
    @IBOutlet weak var vBackground: UIView!
   
    @IBOutlet weak var imgvIcon: UIImageView!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    static let identifier = "cvActionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()

        vBackground.layer.cornerRadius = vBackground.frame.size.height / 2
        vBackground.clipsToBounds = true
        // Initialization code
    }

}
