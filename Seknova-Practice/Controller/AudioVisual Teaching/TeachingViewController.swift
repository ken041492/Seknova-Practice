//
//  TeachingViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/23.
//

import UIKit
import WebKit
import RealmSwift

class TeachingViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var wbvVideo: WKWebView!
    
    @IBOutlet weak var btnNext: UIButton!
    // MARK: - Variables
    var isVideoPlaying = false

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
//        let realm = try! Realm()
//        let userInfo = realm.objects(UserInformation.self)
//        print(userInfo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        lbTitle.text = NSLocalizedString("Audiovisual Teaching", comment: "")
        btnNext.setTitle(NSLocalizedString("Next", comment: ""), for: .normal)
        let url = URL(string: "https://www.youtube.com//embed/Tzmisk385aw?loop=0")!
        let request = URLRequest(url: url)
        wbvVideo.load(request)
        wbvVideo.allowsBackForwardNavigationGestures = true
    }
    
    func setupNavigation() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    // MARK: - IBAction
    
    @IBAction func jumpToSetupBlood(_ sender: Any) {
        let bloodSugarVC = BloodSugarViewController()
        navigationController?.pushViewController(bloodSugarVC, animated: true)
    }
    

}
// MARK: - Extension

// MARK: - Protocol


