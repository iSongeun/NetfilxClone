//
//  MainNaviViewController.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/14.
//

import UIKit

class MainNaviViewController: UINavigationController {

    let statusBarHeight = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.statusBarManager?.statusBarFrame.height ?? 0
    //initial 이후에 접근 -> lazy
    lazy var visualEffectView : UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        effectView.frame = self.navigationBar.bounds.insetBy(dx: 0, dy: -statusBarHeight).offsetBy(dx: 0, dy: -statusBarHeight)
        effectView.alpha = 0
        return effectView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
//        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.compactScrollEdgeAppearance = appearance
        
        let logo = UIImage(named: "netflix_logo")
        let logoButton = UIButton()
        logoButton.setImage(logo, for: .normal)
        logoButton.frame = CGRect(x: 10, y: -5, width: 40, height: 40)

        
        self.navigationBar.addSubview(visualEffectView)
        self.navigationBar.addSubview(logoButton)
//        다른 버튼 추가 방법 밑에
//        logoButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        logoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        self.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: logoButton)
    }
}
