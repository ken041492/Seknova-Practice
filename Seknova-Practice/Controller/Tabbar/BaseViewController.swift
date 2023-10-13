//
//  BaseViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/12.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    
    // MARK: - Variables
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarStyle(backgroundColor: .black)

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
    
    public func setupNavigationBarStyle(backgroundColor: UIColor,
                                        tintColor: UIColor = .white,
                                        foregroundColor: UIColor = .white) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        self.navigationController?.navigationBar.tintColor = tintColor
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : foregroundColor
        ]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        self.navigationItem.title = title
    }
    // MARK: - IBAction
    
    /// NavigationController.pushViewController 跳頁 (不帶 Closure)
    ///
    /// 一般常見的 self.navigationController.pushViewController
    ///
    /// - Parameters:
    ///   - nextVC: 要跳頁到的 UIViewController
    ///   - animated: 是否要換頁動畫，預設為 true
    public func pushViewController(nextVC: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(nextVC, animated: animated)
    }
    
    /// NavigationController.pushViewController 跳頁 (不帶 Closure)
    ///
    /// 用 UIApplication.shared.connectScenes 裡面第一個是 keyWindow 的 rootViewController 來當作 UINavigationController，來進行 pushViewController
    ///
    /// - Parameters:
    ///   - viewController: 要跳頁到的 UIViewController
    ///   - animated: 是否要換頁動畫，預設為 true
    public func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        if let navigationController = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?
            .rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
    /// NavigationController.pushViewController 跳頁 (帶 Closure)
    /// - Parameters:
    ///   - viewController: 要跳頁到的 UIViewController
    ///   - animated: 是否要換頁動畫
    ///   - completion: 換頁過程中，要做的事
    public func pushViewController(_ viewController: UIViewController,
                                   animated: Bool,
                                   completion: @escaping () -> Void) {
        self.navigationController?.pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

    /// NavigationController.pushViewController 跳頁時刪掉舊的畫面 (不帶 Closure)
    /// - Parameters:
    ///   - currentVC: 現在的 UIViewController
    ///   - nextVC: 要跳頁到的 UIViewController
    ///   - animated: 是否要換頁動畫
    public func pushViewController(currentVC: UIViewController,
                                   nextVC: UIViewController,
                                   animated: Bool) {
        navigationController?.pushViewController(nextVC, animated: true)

        guard self.navigationController != nil &&
                self.navigationController?.viewControllers != nil else {
            return
        }

        // 刪除上一個畫面
        let arrayVC = NSMutableArray(array: (self.navigationController?.viewControllers)!)
        for vc in arrayVC {
            if (vc as! UIViewController) == currentVC  {
                arrayVC.remove(vc)
                break
            }
        }

        self.navigationController?.viewControllers = arrayVC as! [UIViewController]
    }
    /// NavigationController.pushViewController 跳頁時刪掉舊的畫面 (帶 Closure)
    /// - Parameters:
    ///   - currentVC: 現在的 UIViewController
    ///   - nextVC: 要跳頁到的 UIViewController
    ///   - animated: 是否要換頁動畫
    ///   - completion: 換頁過程中，要做的事
    public func pushViewController(currentVC: UIViewController,
                                   nextVC: UIViewController,
                                   animated: Bool,
                                   completion: @escaping () -> Void) {
        navigationController?.pushViewController(nextVC, animated: true)

        guard self.navigationController != nil &&
                self.navigationController?.viewControllers != nil else {
            return
        }

        // 刪除上一個畫面
        let arrayVC = NSMutableArray(array: (self.navigationController?.viewControllers)!)
        for vc in arrayVC {
            if (vc as! UIViewController) == currentVC  {
                arrayVC.remove(vc)
                break
            }
        }

        self.navigationController?.viewControllers = arrayVC as! [UIViewController]

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async {
                completion()
            }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in
            completion()
        }
    }
    /// NavigationController.popViewController 回上一頁 (不帶 Closure)
    /// - Parameters:
    ///   - animated: 是否要換頁動畫，預設為 true
    public func popViewController(_ animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    /// NavigationController.popViewController 回上一頁 (帶 Closure)
    /// - Parameters:
    ///   - animated: 是否要換頁動畫
    ///   - completion: 換頁過程中，要做的事
    public func popViewController(animated: Bool, completion: @escaping () -> Void) {
        self.navigationController?.popViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    /// NavigationController.popToViewController 回到指定 ViewController (不帶 Closure)
    /// - Parameters:
    ///   - currentVC: 目前所在的 ViewController
    ///   - popVC_index: 在 NavigationController.viewControllers 中，指定 ViewController 的 index
    ///   - animated: 是否要換頁動畫，預設為 true
    public func popToViewController(currentVC viewController: UIViewController,
                                    popVC_index: Int,
                                    animated: Bool = true) {
        guard let currentVC_index = navigationController?.viewControllers.firstIndex(of: self) else { return }
        if let vc = navigationController?.viewControllers[currentVC_index - popVC_index] {
            self.navigationController?.popToViewController(vc, animated: animated)
        }
    }
    /// NavigationController.popToViewController 回到指定 ViewController (不帶 Closure)
    ///
    /// 一般常見的 self.navigationController?.popToViewController
    ///
    /// - Parameters:
    ///   - viewController: 要 pop 回去的 ViewController
    ///   - animated: 是否要換頁動畫，預設為 true
    public func popToViewController(_ viewController: UIViewController,
                                    animated: Bool = true) {
        self.navigationController?.popToViewController(viewController, animated: animated)
    }
    /// NavigationController.popToViewController 回到指定 ViewController (帶 Closure)
    /// - Parameters:
    ///   - viewController: 要 pop 回去的 ViewController
    ///   - animated: 是否要換頁動畫
    ///   - completion: 換頁過程中，要做的事
    public func popToViewController(_ viewController: UIViewController,
                                    animated: Bool,
                                    completion: @escaping () -> Void) {
        self.navigationController?.popToViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    /// NavigationController.popToRootViewController 回到 Root ViewController
    /// - Parameters:
    ///   - animated: 是否要換頁動畫，預設為 true
    public func popToRootViewController(_ animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    /// NavigationController.dismiss (帶 Closure)
    /// - Parameters:
    ///   - animated: 是否要關閉動畫，預設為 true
    ///   - completion: 關閉過程中，要做的事，預設為 nil
    public func dismissViewController(_ animated: Bool = true, completion: (()-> Void)? = nil) {
        self.navigationController?.dismiss(animated: animated, completion: completion)
    }
    /// ViewController.popUp (帶 Closure)
    /// - Parameters:
    ///   - viewController: 要彈出的 ViewController
    ///   - modalPresentationStyle: UIModalPresentationStyle，預設為 .overFullScreen
    ///   - modalTransitionStyle: UIModalTransitionStyle，預設為 .coverVertical
    ///   - animated: 是否要彈出動畫，預設為 true
    ///   - completion: 彈出過程中，要做的事，預設為 nil
    ///
    ///
//    public func popUpViewController(viewController: UIViewController,
//                                    modalPresentationStyle: ModalPresentationStyle = .overFullScreen,
//                                    modalTransitionStyle: ModalTransitionStyle = .coverVertical,
//                                    animated: Bool = true,
//                                    completion: (()-> Void)? = nil) {
//        viewController.modalPresentationStyle = modalPresentationStyle
//        viewController.modalTransitionStyle = modalTransitionStyle
//        self.present(viewController, animated: animated, completion: completion)
//    }
    
    
    /// ViewController.dismissPopUp
    /// - Parameters:
    ///   - animated: 是否要關閉動畫，預設為 true
    ///   - completion: 關閉過程中，要做的事，預設為 nil
    public func dismissPopUpViewController(_ animated: Bool = true, completion: (()-> Void)? = nil) {
        self.dismiss(animated: animated, completion: completion)
    }
    /// 清除 NavigationStack 中除了下一個畫面以外的畫面
    /// - Parameters:
    ///   - viewController: 下一個畫面的 ViewController
    public func cleanViewControllers(viewController: UIViewController) {
        guard viewController.navigationController?.viewControllers != nil else {
            return
        }
        var vcs = viewController.navigationController!.viewControllers
        for _ in 0 ..< vcs.count - 1 {
            vcs.remove(at: 0)
        }
        DispatchQueue.main.async {
            viewController.navigationController!.viewControllers = vcs
        }
    }
    
}
// MARK: - Extension

// MARK: - Protocol


