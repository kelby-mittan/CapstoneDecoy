//
//  BezierView.swift
//  CapstonePractice
//
//  Created by Kelby Mittan on 5/31/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class BezierView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil // TODO
    }
    
    override func draw(_ rect: CGRect) {
        // Fill the whole background with the darkest blue color
//        let white: UIColor = .white
//        white.set()
//        white.withAlphaComponent(0.0)
                UIColor(red: 0, green: 0, blue: 0, alpha: 0).set()
        let bg = UIBezierPath(rect: rect)
        bg.fill()
        
        // Add the first sine wave filled with a very transparent white
        let top1: CGFloat = 17.0
        let wave1 = wavyPath(rect: CGRect(x: 0, y: top1, width: frame.width, height: frame.height - top1), periods: 1.15, amplitude: 9, start: 4)
        let clear: UIColor = .systemTeal
        clear.set()
        //        UIColor(white: 1, alpha: 0.8).set()
        wave1.fill()
        
        
        
        // Add the second sine wave over the first
        //        let top2: CGFloat = 34.0
        //        let wave2 = wavyPath(rect: CGRect(x: 0, y: top2, width: frame.width, height: frame.height - top2), periods: 1.5, amplitude: 21, start: 0.9)
        //        UIColor(white: 1.0, alpha: 0.15).set()
        //        wave2.fill()
        
        // Add the text
        //        let paraAttrs = NSMutableParagraphStyle()
        //        paraAttrs.alignment = .center
        //        let textRect = CGRect(x: 0, y: frame.maxY - 64, width: frame.width, height: 24)
        //        let textAttrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.9), NSAttributedString.Key.paragraphStyle: paraAttrs]
        //        ("New user? Register here." as NSString).draw(in: textRect, withAttributes: textAttrs)
    }
    
    // This creates the desired sine wave bezier path
    // rect is the area to fill with the sine wave
    // periods is how may sine waves fit across the width of the frame
    // amplitude is the height in points of the sine wave
    // start is an offset in wavelengths for the left side of the sine wave
    func wavyPath(rect: CGRect, periods: Double, amplitude: Double, start: Double) -> UIBezierPath {
        let path = UIBezierPath()
        
        // start in the bottom left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        let radsPerPoint = Double(rect.width) / periods / 2.0 / Double.pi
        let radOffset = start * 2 * Double.pi
        let xOffset = Double(rect.minX)
        let yOffset = Double(rect.maxY) - amplitude
        // This loops through the width of the frame and calculates and draws each point along the size wave
        // Adjust the "by" value as needed. A smaller value gives smoother curve but takes longer to draw. A larger value is quicker but gives a rougher curve.
        for x in stride(from: 0, to: Double(rect.width), by: 6) {
            let rad = Double(x) / radsPerPoint + radOffset
            let y = sin(rad) * amplitude
            
            path.addLine(to: CGPoint(x: x + xOffset, y: y + yOffset))
        }
        
        // Add the last point on the sine wave at the right edge
        let rad = Double(rect.width) / radsPerPoint + radOffset
        let y = sin(rad) * amplitude
        
        path.addLine(to: CGPoint(x: Double(rect.maxX), y: y + yOffset))
        
        // Add line from the end of the sine wave to the bottom right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        // Close the path
        path.close()
        
        return path
    }
}

// This creates the view with the same size as the image posted in the question
//let wavyV = WavyView(frame: CGRect(x: 0, y: 0, width: 502, height: 172))


class Bezier: UIView {
    
    
    public lazy var wView: WavyView = {
        let wavy = WavyView()
                wavy.backgroundColor = .clear
        return wavy
    }()
    
    public lazy var wImageView: WavyImageView = {
        let wavy = WavyImageView(frame: CGRect(x: 0, y: 0, width: 502, height: 172))
        //        wavy.backgroundColor = .red
        //        wavy.image = UIImage(named: "nycSeaLevel1")
        
        return wavy
    }()
    
        public lazy var imageView: UIImageView = {
            let iv = UIImageView()
            iv.image = UIImage(named: "nycSeaLevel1")
            iv.contentMode = .scaleToFill
            iv.clipsToBounds = true
    
//            let bg = UIBezierPath(rect: CGRect(x: 0, y: iv.frame.height - 20, width: iv.frame.width, height: iv.frame.height))
//            bg.fill()
//
//            // Add the first sine wave filled with a very transparent white
//            let top1: CGFloat = 17.0
//            let wave1 = wavyPath(rect: CGRect(x: 0, y: top1, width: frame.width, height: frame.height - top1), periods: 1.1, amplitude: 08, start: 0.05)
//            UIColor(white: 1.0, alpha: 0.8).set()
//            wave1.fill()
            addWaveBackground(to: iv)
            return iv
        }()
    
    public lazy var theView: UIView = {
        let v = UIView()
        v.backgroundColor = .orange
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        //        setupTheView()
        
                setupImageView()
        setupWaveView()
        //        setupWaveImageView()
    }
    
    private func setupTheView() {
        addSubview(theView)
        theView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            theView.centerXAnchor.constraint(equalTo: centerXAnchor),
            theView.centerYAnchor.constraint(equalTo: centerYAnchor),
            theView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            theView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupWaveView() {
        addSubview(wView)
        wView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wView.centerXAnchor.constraint(equalTo: centerXAnchor),
            //            wView.centerYAnchor.constraint(equalTo: centerYAnchor),
            wView.topAnchor.constraint(equalTo: self.topAnchor),
            wView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            wView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupWaveImageView() {
        imageView.addSubview(wImageView)
        wImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            wView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            wImageView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            wImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    
        private func setupImageView() {
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
    
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: self.topAnchor),
                imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
                imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
            ])
        }
    
}

class WavyImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil // TODO
    }
    
    override func draw(_ rect: CGRect) {
        // Fill the whole background with the darkest blue color
        let white: UIColor = .secondarySystemBackground
        white.set()
        //        let image = UIImage(named: "nycSeaLevel1")
        //        UIColor(red: 0.329, green: 0.218, blue: 0.875, alpha: 1).set()
        let bg = UIBezierPath(rect: rect)
        bg.fill()
        
        // Add the first sine wave filled with a very transparent white
        let top1: CGFloat = 17.0
        let wave1 = wavyPath(rect: CGRect(x: 0, y: top1, width: frame.width, height: frame.height - top1), periods: 1.1, amplitude: 08, start: 0.05)
        let clear: UIColor = .systemTeal
        clear.set()
        //        UIColor(white: 1, alpha: 0.8).set()
        wave1.fill()
        
        
        
        // Add the second sine wave over the first
        //        let top2: CGFloat = 34.0
        //        let wave2 = wavyPath(rect: CGRect(x: 0, y: top2, width: frame.width, height: frame.height - top2), periods: 1.5, amplitude: 21, start: 0.9)
        //        UIColor(white: 1.0, alpha: 0.15).set()
        //        wave2.fill()
        
        // Add the text
        //        let paraAttrs = NSMutableParagraphStyle()
        //        paraAttrs.alignment = .center
        //        let textRect = CGRect(x: 0, y: frame.maxY - 64, width: frame.width, height: 24)
        //        let textAttrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.9), NSAttributedString.Key.paragraphStyle: paraAttrs]
        //        ("New user? Register here." as NSString).draw(in: textRect, withAttributes: textAttrs)
    }
    
    // This creates the desired sine wave bezier path
    // rect is the area to fill with the sine wave
    // periods is how may sine waves fit across the width of the frame
    // amplitude is the height in points of the sine wave
    // start is an offset in wavelengths for the left side of the sine wave
    func wavyPath(rect: CGRect, periods: Double, amplitude: Double, start: Double) -> UIBezierPath {
        let path = UIBezierPath()
        
        // start in the bottom left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        let radsPerPoint = Double(rect.width) / periods / 2.0 / Double.pi
        let radOffset = start * 2 * Double.pi
        let xOffset = Double(rect.minX)
        let yOffset = Double(rect.maxY) - amplitude
        // This loops through the width of the frame and calculates and draws each point along the size wave
        // Adjust the "by" value as needed. A smaller value gives smoother curve but takes longer to draw. A larger value is quicker but gives a rougher curve.
        for x in stride(from: 0, to: Double(rect.width), by: 6) {
            let rad = Double(x) / radsPerPoint + radOffset
            let y = sin(rad) * amplitude
            
            path.addLine(to: CGPoint(x: x + xOffset, y: y + yOffset))
        }
        
        // Add the last point on the sine wave at the right edge
        let rad = Double(rect.width) / radsPerPoint + radOffset
        let y = sin(rad) * amplitude
        
        path.addLine(to: CGPoint(x: Double(rect.maxX), y: y + yOffset))
        
        // Add line from the end of the sine wave to the bottom right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        // Close the path
        path.close()
        
        return path
    }
}

func addWaveBackground(to view: UIImageView){
    let leftDrop:CGFloat = 0.4
    let rightDrop: CGFloat = 0.3
    let leftInflexionX: CGFloat = 0.4
    let leftInflexionY: CGFloat = 0.47
    let rightInflexionX: CGFloat = 0.6
    let rightInflexionY: CGFloat = 0.22
    
    let backView = UIImageView(frame: view.frame)
    backView.backgroundColor = .gray
    view.addSubview(backView)
    let backLayer = CAShapeLayer()
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x:0, y: view.frame.height * leftDrop))
    path.addCurve(to: CGPoint(x:view.frame.width, y: view.frame.height * rightDrop),
                  controlPoint1: CGPoint(x: view.frame.width * leftInflexionX, y: view.frame.height * leftInflexionY),
                  controlPoint2: CGPoint(x: view.frame.width * rightInflexionX, y: view.frame.height * rightInflexionY))
    path.addLine(to: CGPoint(x:view.frame.width, y: 0))
    path.close()
    backLayer.fillColor = UIColor.blue.cgColor
    backLayer.path = path.cgPath
    backView.image = UIImage(named: "nycSeaLevel1")
    backView.layer.addSublayer(backLayer)
}
