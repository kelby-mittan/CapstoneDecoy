//
//  DetailView.swift
//  CapstonePractice
//
//  Created by Kelby Mittan on 5/29/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Charts

class DetailView: UIView {
    
    public lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = .clear
        return scrollview
    }()
    
    public lazy var headerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    public lazy var locationImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "nycSeaLevel1")
        iv.clipsToBounds = true
        iv.alpha = 1
        return iv
    }()
    
    public lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "New York City"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        return label
    }()
    
    public lazy var seaLevelFactsLabel: UILabel = {
        let label = UILabel()
        label.text = "Did you know?"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    public lazy var seaLevelContentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    public lazy var looksLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "What this looks like"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    public lazy var looksLikeContentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    public lazy var graphLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Sea Level Rise by 2100"
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
//    public lazy var seaLevelGraphView: UIView = {
//        let graphView = UIView()
//        graphView.backgroundColor = .systemOrange
//        graphView.layer.cornerRadius = 5
//        graphView.clipsToBounds = true
//        return graphView
//    }()
    
    public lazy var seaLevelLineChart: LineChartView = {
        let lineChart = LineChartView()
        lineChart.backgroundColor = .systemBlue
        lineChart.layer.cornerRadius = 5
        lineChart.clipsToBounds = true
        lineChart.rightAxis.enabled = false
        let yAxis = lineChart.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(5, force: false)
        yAxis.axisLineColor = .white
        yAxis.labelTextColor = .white
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.labelTextColor = .white
        lineChart.xAxis.axisLineColor = .white
        yAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.setLabelCount(5, force: false)
//        lineChart.animate(xAxisDuration: 10)
        
        return lineChart
    }()
    
    public lazy var populationFactsLabel: UILabel = {
        let label = UILabel()
        label.text = "Where will we go?"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    public lazy var populationContentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    public lazy var populationGraphLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Population Displacement"
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    public lazy var populationGraphView: LineChartView = {
        let lineChart = LineChartView()
        lineChart.backgroundColor = .green
        lineChart.layer.cornerRadius = 5
        lineChart.clipsToBounds = true
        return lineChart
    }()
    
    public lazy var goToARButton: UIButton = {
        let button = UIButton()
        button.setTitle("AR Experience", for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 5
        return button
    }()
    
    public lazy var arView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        return view
    }()
    
    var headerContainerViewBottom : NSLayoutConstraint!
    var imageViewTopConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        scrollViewContraints()
        setupSeaLevelLabelConstraints()
        headerContainer()
        setupLocationImageConstraints()
        setupLocationLabel()
        seaLevelFactsConstraints()
        setupLooksLikeConstraints()
        setupLooksLikeContentConstraints()
        graphLabelConstraints()
//        seaLevelGraphConstraints()
        setupSeaLevelLineChart()
        setupPopulationLabelConstraints()
        populationContentConstraints()
        populationGraphLabelConstraints()
        populationGraphConstraints()
        setupARView()
        arButtonConstraints()
        
    }
    
    private func scrollViewContraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func headerContainer() {
        self.scrollView.addSubview(headerContainerView)
        
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        headerContainerViewBottom = self.headerContainerView.bottomAnchor.constraint(equalTo: self.seaLevelFactsLabel.topAnchor, constant: -10)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerViewBottom.isActive = true
    }
    
    private func setupLocationImageConstraints() {
        
        headerContainerView.addSubview(locationImage)
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationImage.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            locationImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationImage.bottomAnchor.constraint(equalTo: seaLevelFactsLabel.topAnchor, constant: -20)
        ])
        
        imageViewTopConstraint = self.locationImage.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        imageViewTopConstraint.isActive = true
    }
    
    private func setupLocationLabel() {
        locationImage.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationLabel.bottomAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: -10),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupSeaLevelLabelConstraints() {
        scrollView.addSubview(seaLevelFactsLabel)
        seaLevelFactsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            seaLevelFactsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 280),
            seaLevelFactsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            seaLevelFactsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
    
    private func seaLevelFactsConstraints() {
        scrollView.addSubview(seaLevelContentLabel)
        seaLevelContentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            seaLevelContentLabel.topAnchor.constraint(equalTo: seaLevelFactsLabel.bottomAnchor, constant: 8),
            seaLevelContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            seaLevelContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupLooksLikeConstraints() {
        scrollView.addSubview(looksLikeLabel)
        looksLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            looksLikeLabel.topAnchor.constraint(equalTo: seaLevelContentLabel.bottomAnchor, constant: 20),
            looksLikeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            looksLikeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupLooksLikeContentConstraints() {
        scrollView.addSubview(looksLikeContentLabel)
        looksLikeContentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            looksLikeContentLabel.topAnchor.constraint(equalTo: looksLikeLabel.bottomAnchor, constant: 8),
            looksLikeContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            looksLikeContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func graphLabelConstraints() {
        scrollView.addSubview(graphLabel)
        graphLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            graphLabel.topAnchor.constraint(equalTo: looksLikeContentLabel.bottomAnchor, constant: 20),
            graphLabel.leadingAnchor.constraint(equalTo: looksLikeContentLabel.leadingAnchor),
            graphLabel.trailingAnchor.constraint(equalTo: looksLikeContentLabel.trailingAnchor)
        ])
    }
    
//    private func seaLevelGraphConstraints(){
//        scrollView.addSubview(seaLevelGraphView)
//        seaLevelGraphView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            seaLevelGraphView.topAnchor.constraint(equalTo: graphLabel.bottomAnchor, constant: 8),
//            seaLevelGraphView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
//            seaLevelGraphView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            seaLevelGraphView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
//        ])
//    }
    
    private func setupSeaLevelLineChart() {
        scrollView.addSubview(seaLevelLineChart)
        seaLevelLineChart.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint.activate([
//            seaLevelLineChart.topAnchor.constraint(equalTo: seaLevelGraphView.topAnchor),
//            seaLevelLineChart.bottomAnchor.constraint(equalTo: seaLevelGraphView.bottomAnchor),
//            seaLevelLineChart.leadingAnchor.constraint(equalTo: seaLevelGraphView.leadingAnchor),
//            seaLevelLineChart.trailingAnchor.constraint(equalTo: seaLevelGraphView.trailingAnchor)
//        ])
        
        NSLayoutConstraint.activate([
            seaLevelLineChart.topAnchor.constraint(equalTo: graphLabel.bottomAnchor, constant: 8),
            seaLevelLineChart.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            seaLevelLineChart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            seaLevelLineChart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupPopulationLabelConstraints() {
        scrollView.addSubview(populationFactsLabel)
        populationFactsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            populationFactsLabel.topAnchor.constraint(equalTo: seaLevelLineChart.bottomAnchor, constant: 20),
            populationFactsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            populationFactsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
    
    private func populationContentConstraints() {
        scrollView.addSubview(populationContentLabel)
        populationContentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            populationContentLabel.topAnchor.constraint(equalTo: populationFactsLabel.bottomAnchor, constant: 8),
            populationContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            populationContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func populationGraphLabelConstraints() {
        scrollView.addSubview(populationGraphLabel)
        populationGraphLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            populationGraphLabel.topAnchor.constraint(equalTo: populationContentLabel.bottomAnchor, constant: 20),
            populationGraphLabel.leadingAnchor.constraint(equalTo: populationContentLabel.leadingAnchor),
            populationGraphLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func populationGraphConstraints(){
        scrollView.addSubview(populationGraphView)
        populationGraphView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            populationGraphView.topAnchor.constraint(equalTo: populationGraphLabel.bottomAnchor, constant: 8),
            populationGraphView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            populationGraphView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            populationGraphView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            populationGraphView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -80)
        ])
    }
    
    private func setupARView() {
        addSubview(arView)
        arView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //            goToARButton.topAnchor.constraint(equalTo: populationGraphView.bottomAnchor, constant: 20),
            arView.centerXAnchor.constraint(equalTo: centerXAnchor),
            arView.widthAnchor.constraint(equalTo: widthAnchor),
            arView.heightAnchor.constraint(equalToConstant: 100),
            arView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func arButtonConstraints() {
        addSubview(goToARButton)
        goToARButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //            goToARButton.topAnchor.constraint(equalTo: populationGraphView.bottomAnchor, constant: 20),
            goToARButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            goToARButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            goToARButton.heightAnchor.constraint(equalToConstant: 44),
            goToARButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
