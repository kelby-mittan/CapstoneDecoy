//
//  LocationDetailVC.swift
//  CapstonePractice
//
//  Created by Kelby Mittan on 5/24/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class LocationDetailVC: UIViewController {
    
    private var locationView = DetailView()
    
    var isStatusBarHidden = false
    
    private let headerViewMaxHeight: CGFloat = 250
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func loadView() {
        view = locationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        
        //        navigationController?.navigationBar.prefersLargeTitles = true
        
        locationView.goToARButton.addTarget(self, action: #selector(goToARButtonPressed(_:)), for: .touchUpInside)
        locationView.scrollView.delegate = self
        
        print(locationView.seaLevelFactsLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = ""
        
        //        self.navigationController?.prefersStatusBarHidden
        //        if locationView.headerContainerViewBottom == locationView.safeAreaLayoutGuide.topAnchor {
        //            isStatusBarHidden = true
        //            UIView.animate(withDuration: 0.7) {
        //                self.setNeedsStatusBarAppearanceUpdate()
        //            }
        //        }
        
        
        
    }
    
    
    @objc func goToARButtonPressed(_ sender: UIBarButtonItem) {
        
        print("AR Button Pressed")
        
        let stickyVC = StickyHeaderController()
        present(stickyVC, animated: true)
        
        //                isStatusBarHidden.toggle()
        //                UIView.animate(withDuration: 0.7) {
        //                    self.setNeedsStatusBarAppearanceUpdate()
        //                }
    }
}

extension LocationDetailVC: UIScrollViewDelegate {
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.7) {
            self.setNeedsStatusBarAppearanceUpdate()
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        print(y)
        
        if y > 60 {
            isStatusBarHidden = true
            animateStatusBar()
        } else {
            isStatusBarHidden = false
            animateStatusBar()
        }
        //        let newHeaderViewHeight: CGFloat = locationView.headerViewHeightConstraint.constant - y
        ////
        //        if newHeaderViewHeight > headerViewMaxHeight {
        //            locationView.headerViewHeightConstraint.constant = headerViewMaxHeight
        //        } else if newHeaderViewHeight < locationView.headerViewMinHeight {
        //            locationView.headerViewHeightConstraint.constant = locationView.headerViewMinHeight
        //        } else {
        //            locationView.headerViewHeightConstraint.constant = newHeaderViewHeight
        //            scrollView.contentOffset.y = 0
        //        }
    }
    
}
