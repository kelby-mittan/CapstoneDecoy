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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        
        locationView.goToARButton.addTarget(self, action: #selector(goToARButtonPressed(_:)), for: .touchUpInside)
        locationView.backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
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
        
        //        let stickyVC = StickyHeaderController()
        //        present(stickyVC, animated: true)
        //        navigationController?.pushViewController(stickyVC, animated: true)
        
        //                isStatusBarHidden.toggle()
        //                UIView.animate(withDuration: 0.7) {
        //                    self.setNeedsStatusBarAppearanceUpdate()
        //                }
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem) {
        
        print("Back Button Pressed")
        
        setSeaLevelData()
        //        locationView.seaLevelLineChart.animate(xAxisDuration: 4)
        //        locationView.seaLevelLineChart.animate(xAxisDuration: 2, yAxisDuration: 6.5, easingOption: .easeInCirc)
        locationView.seaLevelLineChart.animate(xAxisDuration: 10)
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

        print(locationView.triggerSLView2.frame.height - locationView.triggerSLView1.frame.height)
        
        if y > 60 {
            isStatusBarHidden = true
            animateStatusBar()
        } else {
            isStatusBarHidden = false
            animateStatusBar()
        }
        
        triggerGraphAnimation()
        
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
    
    func triggerGraphAnimation() {
        let triggerHeight = locationView.triggerSLView2.frame.height - locationView.triggerSLView1.frame.height
        if triggerHeight > 10 && triggerHeight < 30 {
            setSeaLevelData()
            locationView.seaLevelLineChart.animate(xAxisDuration: 2, yAxisDuration: 6.5, easingOption: .easeInCirc)
        }
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
        set.fillAlpha = 0.6
        set.drawFilledEnabled = true
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.drawVerticalHighlightIndicatorEnabled = false
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
