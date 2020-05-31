//
//  LocationDetailVC.swift
//  CapstonePractice
//
//  Created by Kelby Mittan on 5/24/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Charts

class LocationDetailVC: UIViewController {
    
    private var locationView = DetailView()
    
    private var waveV = Wave()
    
    private let locations = FactsData.getLocations()
    
    var isStatusBarHidden = false
    
    private let headerViewMaxHeight: CGFloat = 250
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func loadView() {
        view = waveV
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        locationView.goToARButton.addTarget(self, action: #selector(goToARButtonPressed(_:)), for: .touchUpInside)
        locationView.scrollView.delegate = self
        locationView.seaLevelLineChart.delegate = self
        locationView.populationGraphView.delegate = self
        setupUI()
//        setSeaLevelData()
    }
    
    private func setupUI() {
        let nyc = locations[0]
        locationView.locationLabel.text = nyc.location
        locationView.seaLevelContentLabel.text = nyc.facts.generalFacts
        locationView.looksLikeContentLabel.text = nyc.facts.seaLevelFacts
        locationView.populationContentLabel.text = nyc.facts.populationFacts
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = ""
        
    }
    
    
    @objc func goToARButtonPressed(_ sender: UIBarButtonItem) {
        
        print("AR Button Pressed")
        
        setSeaLevelData()
//        locationView.seaLevelLineChart.animate(xAxisDuration: 4)
        locationView.seaLevelLineChart.animate(xAxisDuration: 2, yAxisDuration: 3.5, easingOption: .easeInCirc)
        
//        let stickyVC = StickyHeaderController()
//        present(stickyVC, animated: true)
//        navigationController?.pushViewController(stickyVC, animated: true)
        
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
//        print(y)
        
        if y > 60 {
            isStatusBarHidden = true
            animateStatusBar()
        } else {
            isStatusBarHidden = false
            animateStatusBar()
        }
        
//        if y > 400 {
//            locationView.seaLevelLineChart.animate(xAxisDuration: 10)
//        }
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

extension LocationDetailVC: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setSeaLevelData() {
        let set = LineChartDataSet(entries: getSeaLevelData(), label: "")
//        let set = LineChartDataSet(entries: getSeaLevelData())
        set.circleRadius = 3
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.setCircleColor(.white)
        set.setColor(.white)
        set.fill = Fill(color: .white)
        set.fillAlpha = 0.7
        set.drawFilledEnabled = true
        set.drawHorizontalHighlightIndicatorEnabled = false
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        locationView.seaLevelLineChart.data = data
    }
    
    func getSeaLevelData() -> [ChartDataEntry] {
        var dataEntry: [ChartDataEntry] = []
        
        for data in locations[0].dataSet {
            let entry = ChartDataEntry(x: Double(data.year), y: data.level)
            dataEntry.append(entry)
        }
        return dataEntry
    }
}
