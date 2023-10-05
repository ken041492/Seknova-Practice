//
//  PrivacyBookViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/14.
//

import UIKit

class PrivacyBookViewController: UIViewController {
    
    // MARK: - IBOutlet
            
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbText: UILabel!
    
    @IBOutlet weak var btnApprove: UIButton!
    
    // MARK: - Variables
    
    var agreen: Bool = false
    var delegate: ChangeBTNColor?

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.changeButtonColor()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        lbTitle.text = "Seknova應用程式使用條款"
        lbText.text = "本使用條款（以下簡稱“本條款”）是智準生醫科技股份有限公司（以下簡稱“智準生醫”）與智準生醫產品用戶或購買者（您）之間的協議。本條款適用於您使用或訪問智準生醫提供的工具及服務（包括但不限於智準生醫智準生醫運營的其他網站，智準生醫在網站、蘋果應用商店或其他移動服務平台提供下載及訪問的App）。\n當您使用任何智準生醫網站、App或點擊“接受”條款時，即表示同意您同意本條款。時閱讀本條款。本條款最近更新時間為2021年9月1日。\n\n醫療信息\n智準生醫網站或App上提供的產品或服務等相關信息僅用於一般的信息傳遞及達到一般的教育目的。\n\n智準生醫提供醫療建議。\n智準生醫不提供醫療、治療服務等相關建議，智準生醫網站或醫療保健應用程序上的信息也不應接受醫療建議。\n\n創作權與商標\n智準生醫網站或應用程序內容的所有權為智準生醫網站或應用程序內容受《中華民國著作權》（以下簡稱“著作權法”）保護。時，您必須遵守權利法的相關規定。\n\n智準生醫產品及服務的名稱為智準生醫所有，且受《中華民國商標法》（以下簡稱“商標法”）保護。智準生醫網站App中帶有右上標“®”符號的名稱已經被註冊商標；伴隨著右上標“TM”符號的名稱已經作為商標使用。\n如果您以本條款中未明確表示允許以使用智準生醫網站或應用程序的內容或商標的方式，您將違反與智準生醫之間的協議，也可能違反創業權法、商標法或其他法律。發生，智準生醫將自動通知您使用智準生醫網站或應用程序的許可。\n移科技網站或App內容的原型為智準生醫所有。所有未曾存在用戶的權利將被保留。\n\n智準生醫網站或App鏈接\n您將被授權使用智準生醫或App智準生醫。如果您同意智準生醫修改撤銷此授權，您將同意立即移除或停止鏈接使用網站或App上的移動宇科技網站或應用程序鏈接。\n\n不承諾聲明\n智準生醫或App以「當前」、「現有」為基礎提供所有內容，不做任何形式的網站擔保。\n\n智準生醫將不對智準生醫的所有內容準確、網站科技、應用程序或社交性或提供任何保證或陳述，不對這些內容或信息的錯誤、錯誤或遺漏承擔承擔。移動宇科技不保證移動宇科技網站或應用程序不會受到病毒及任何可能破壞計算器或智能設備的程序的影響，您需要自動採取預防措施。訪問及使用智準生醫網站或應用程序的相關行為及針對產生的任何爭議的方法解決受中華民國法律約束。"
        
        btnApprove.setTitle("確認", for: .normal)
    }
    
    
    // MARK: - IBAction

    @IBAction func accept(_ sender: Any) {
        
        if agreen {
            dismiss(animated: false)
        } else {
            let persionalDataVC = PersionalDataViewController()
            navigationController?.pushViewController(persionalDataVC, animated: true)
        }
    }
}
// MARK: - Extension

// MARK: - Protocol


