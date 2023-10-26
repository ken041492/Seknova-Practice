//
//  TabbarView.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/12.
//

import UIKit

class TabbarView: UIView {
    
    @IBOutlet weak var btnNavigation: UIButton!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    var delegate: CustomViewListener?
    var stringTag: Int?
    
    var buttonTapped: ((Int) -> ())? = nil

    
    override func awakeFromNib() {
       addXibView()
    }
    
    @IBAction func didTapBtn(_ sender: Any) {
        delegate?.target?(stringTag: stringTag ?? 0)
    }
    
    func setInit(tag: Int, text: String, image: UIImage) {
        btnNavigation.setImage(image, for: .normal)
        btnNavigation.imageView?.contentMode = .scaleAspectFit
        lbTitle.text = text
        stringTag = tag
    }
}

fileprivate extension TabbarView {
    //加入畫面
    func addXibView() {
        if let loadView = Bundle(for: TabbarView.self).loadNibNamed("TabbarView",
                                owner: self,
                                options: nil)?.first as? UIView{
            
            addSubview(loadView)
            loadView.frame = bounds
        }
        btnNavigation.setTitle("", for: .normal)
    }
}

@objc protocol CustomViewListener: NSObjectProtocol {
    @objc optional func target(stringTag:Int)
}
