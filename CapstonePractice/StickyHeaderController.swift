//
//  StickyHeaderController.swift
//  CapstonePractice
//
//  Created by Kelby Mittan on 5/29/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class StickyHeaderController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .systemTeal
        return sv
    }()
    
    private lazy var stupidLabel: UILabel = {
        let l = UILabel()
        l.text = "TEXT"
        l.textAlignment = .center
        return l
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "pencil"))
        return iv
    }()
    
    private lazy var locationImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "nycSeaLevel1")
        iv.clipsToBounds = true
        iv.alpha = 1
        return iv
    }()
    
    private lazy var headerView: UIView = {
        let v = UIView()
        v.backgroundColor = .magenta
        return v
    }()
    
    private let headerViewMaxHeight: CGFloat = 400
    
    private lazy var headerViewMinHeight: CGFloat = 44 + (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
    
    
    private weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentSize = CGSize(width: 2000, height: 8000)
    }
    
    private func setupView() {
        setupHeaderView()
        setupIV()
        setupScrollView()
        setupLabel()
        setupImageView()
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
        headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 250)
        headerViewHeightConstraint.isActive = true
        
    }
    
    private func setupIV() {
        headerView.addSubview(locationImage)
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationImage.topAnchor.constraint(equalTo: headerView.topAnchor),
            locationImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            locationImage.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            locationImage.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func setupLabel() {
        headerView.addSubview(stupidLabel)
        stupidLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stupidLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            stupidLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            stupidLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)])
    }
    
    private func setupImageView() {
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: stupidLabel.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200)])
    }
    
}

extension StickyHeaderController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        print(y)
        let newHeaderViewHeight: CGFloat = headerViewHeightConstraint.constant - y
        
        if newHeaderViewHeight > headerViewMaxHeight {
            headerViewHeightConstraint.constant = headerViewMaxHeight
        } else if newHeaderViewHeight < headerViewMinHeight {
            headerViewHeightConstraint.constant = headerViewMinHeight
        } else {
            headerViewHeightConstraint.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0
        }
    }
}
