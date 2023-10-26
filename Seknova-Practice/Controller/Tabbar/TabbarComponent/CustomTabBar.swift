//
//  CustomTabBar.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/12.
//

import UIKit

enum BottomItems: Int, CaseIterable {
    case HistoryViewController = 0, BloodSugarCorrectViewController, ImmediateBloodSugarViewController, LifeStyleViewController, PersonalViewController
    
    var title: String{
        switch self {
        case .HistoryViewController:
            return NSLocalizedString("HistoryViewController", comment: "")
        case .BloodSugarCorrectViewController:
            return NSLocalizedString("BloodSugarCorrectViewController", comment: "")
        case .ImmediateBloodSugarViewController:
            return NSLocalizedString("ImmediateBloodSugarViewController", comment: "")
        case .LifeStyleViewController:
            return NSLocalizedString("LifeStyleViewController", comment: "")
        case .PersonalViewController:
            return NSLocalizedString("PersonalViewController", comment: "")
        }
    }
    
}

class CustomTabBar: UIView {
    
    @IBOutlet weak var vHistory: TabbarView!
    
    @IBOutlet weak var vBloodSugarCorrect: TabbarView!
    
    @IBOutlet weak var vImmediateBloodSugar: TabbarView!
    
    @IBOutlet weak var vLifeStyle: TabbarView!
    
    @IBOutlet weak var vPersonal: TabbarView!
    
    
    var buttonTapped: ((Int) -> ())? = nil
    var items = BottomItems.allCases
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addXibView()
    }
}

extension CustomTabBar: CustomViewListener {
    func target(stringTag: Int) {
        buttonTapped?(items[stringTag].rawValue)
        
        //        switch stringTag{
        //        case 0:
        ////            setupNavigation()
        //            print(1)
        //        case 1:
        ////            setupNavigation()
        //            print(1)
        //        case 2:
        ////            setupNavigation()
        //            print(1)
        //        case 3:
        ////            setupNavigation()
        //            print(1)
        //        default:
        ////            setupNavigation()
        //            print(1)
        //        }
        //
        
    }
}

fileprivate extension CustomTabBar {
    //加入畫面
    func addXibView() {
        if let loadView = Bundle(for: CustomTabBar.self).loadNibNamed("CustomTabBar", owner: self, options: nil)?.first as? UIView{
            addSubview(loadView)
            loadView.frame = bounds
        }
        vHistory.delegate = self
        vBloodSugarCorrect.delegate = self
        vImmediateBloodSugar.delegate = self
        vLifeStyle.delegate = self
        vPersonal.delegate = self
        
        vHistory.setInit(tag: 0, text: "歷史紀錄", image: UIImage(named: "history")!)
        vBloodSugarCorrect.setInit(tag: 1, text: "血糖校正", image: UIImage(named: "blood-1")!)
        vImmediateBloodSugar.setInit(tag: 2, text: "即時血糖", image: UIImage(named: "trend")!)
        vLifeStyle.setInit(tag: 3, text: "生活作息", image: UIImage(named: "calendar-1")!)
        vPersonal.setInit(tag: 4, text: "個人資訊", image: UIImage(named: "user")!)
    }
}
