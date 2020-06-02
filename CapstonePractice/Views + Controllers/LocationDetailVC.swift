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
    
    var animateSLGraphCalled = false
    
    private var seaLevelSet = LineChartDataSet()
    
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
        setSeaLevelData()
        setPopulationGraphData()
        
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
        
                let stickyVC = StickyHeaderController()
                present(stickyVC, animated: true)
        
        //                isStatusBarHidden.toggle()
        //                UIView.animate(withDuration: 0.7) {
        //                    self.setNeedsStatusBarAppearanceUpdate()
        //                }
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem) {
        
        print("Back Button Pressed")
        
//        setSeaLevelData()
        //        locationView.seaLevelLineChart.animate(xAxisDuration: 4)
        //        locationView.seaLevelLineChart.animate(xAxisDuration: 2, yAxisDuration: 6.5, easingOption: .easeInCirc)
        locationView.seaLevelLineChart.animate(xAxisDuration: 6)
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

//        print(locationView.triggerSLView2.frame.height - locationView.triggerSLView1.frame.height)
        
        if y > 60 {
            isStatusBarHidden = true
            animateStatusBar()
        } else {
            isStatusBarHidden = false
            animateStatusBar()
        }
        
        print(y)
        
        if y > 130 {
           
            locationView.imageHeightConstraint = locationView.locationImage.bottomAnchor.constraint(equalTo: locationView.topAnchor, constant: 130)
            
            locationView.imageHeightConstraint.isActive = true
            
            locationView.scrollViewTopConstraint = locationView.scrollView.topAnchor.constraint(equalTo: locationView.locationImage.bottomAnchor)
            
            locationView.scrollViewTopConstraint.isActive = true
            
            locationView.bringSubviewToFront(locationView.locationImage)
            locationView.sendSubviewToBack(locationView.scrollView)
            
        } else {
            locationView.imageHeightConstraint = locationView.locationImage.bottomAnchor.constraint(equalTo: locationView.seaLevelFactsLabel.topAnchor, constant: -20)
            
            locationView.imageHeightConstraint.isActive = true
            
            locationView.scrollViewTopConstraint = locationView.scrollView.topAnchor.constraint(equalTo: locationView.topAnchor)
            
            locationView.scrollViewTopConstraint.isActive = true
        }
        
        triggerGraphAnimation()
        
    }
    
    func triggerGraphAnimation() {
        let triggerHeight = locationView.triggerSLView2.frame.height - locationView.triggerSLView1.frame.height
        if triggerHeight > 10 && !animateSLGraphCalled {
            setSeaLevelData()
            seaLevelSet.setCircleColor(.white)
            seaLevelSet.setColor(.white)
            seaLevelSet.fill = Fill(color: .white)
            locationView.seaLevelLineChart.animate(xAxisDuration: 2, yAxisDuration: 2, easingOption: .easeInCirc)
            animateSLGraphCalled = true
        }
        
//        if triggerHeight > 450 {
//            locationView.populationGraphView.animate(xAxisDuration: 5)
//        }
    }
    
}

extension LocationDetailVC: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setSeaLevelData() {
        seaLevelSet = LineChartDataSet(entries: getSeaLevelData())
        seaLevelSet.circleRadius = 3
        seaLevelSet.drawCirclesEnabled = false
        seaLevelSet.mode = .cubicBezier
        seaLevelSet.lineWidth = 3
        seaLevelSet.setCircleColor(.clear)
        seaLevelSet.setColor(.clear)
        seaLevelSet.fill = Fill(color: .clear)
        seaLevelSet.fillAlpha = 0.6
        seaLevelSet.drawFilledEnabled = true
        seaLevelSet.drawHorizontalHighlightIndicatorEnabled = false
        seaLevelSet.drawVerticalHighlightIndicatorEnabled = false
        let data = LineChartData(dataSet: seaLevelSet)
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
    
    func setPopulationGraphData() {
        var entries = [PieChartDataEntry]()
        entries.append(PieChartDataEntry(value: 100000-20000, label: "Population"))
        entries.append(PieChartDataEntry(value: 20000, label: "Displaced"))
        
        let dataSet = PieChartDataSet(entries: entries, label: "")

        let c1 = NSUIColor(hex: 0xC0FFEE)
        let c2 = NSUIColor(hex: 0xFF6347)
        
        dataSet.colors = [c1, c2]
        
        dataSet.drawValuesEnabled = false
        
        
        locationView.populationGraphView.data = PieChartData(dataSet: dataSet)
        locationView.populationGraphView.isUserInteractionEnabled = true
        locationView.populationGraphView.setExtraOffsets(left: -15, top: -10, right: -15, bottom: -15)
    }
}
