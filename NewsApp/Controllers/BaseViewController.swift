//
//  LoginViewController.swift
//  NewsApp
//
//  Created by koki on 2022/01/30.
//

import UIKit
import SegementSlide
import ImpressiveNotifications


class BaseViewController: SegementSlideDefaultViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultSelectedIndex = 0
        reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func segementSlideHeaderView() -> UIView? {
        
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleToFill
        headerView.image = UIImage(named: "header")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerHeight:CGFloat
        if #available(iOS 11.0, *){
            headerHeight = view.bounds.height / 4 + view.safeAreaInsets.top
        }else{
            headerHeight = view.bounds.height / 4 + topLayoutGuide.length
        }
        
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return headerView
    }
        
    override var titlesInSwitcher: [String]{
        return ["TOP","地域","国内","IT","経済","スポーツ"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index {
        case 0:
            return Page1TableViewController()
        case 1:
            return Page2TableViewController()
        case 2:
            return Page3TableViewController()
        case 3:
            return Page4TableViewController()
        case 4:
            return Page5TableViewController()
        case 5:
            return Page6TableViewController()
        
        default:return Page1TableViewController()
        }
        
        
    }
    
}
