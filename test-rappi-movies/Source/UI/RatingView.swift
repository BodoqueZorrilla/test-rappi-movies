//
//  RatingView.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 11/04/22.
//

import UIKit

class RatingView: UIView {

    var percent: Double?

    private let percentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = bounds.width / 2
        self.percentLabel.text = String(percent ?? 0.0)
        self.addSubview(percentLabel)
        percentLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        percentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        percentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        updateGradient(goodAverrage: percent ?? 0.0 > 5.0 ? true : false)
    }
}

private extension RatingView {
    func updateGradient(goodAverrage: Bool) {
        let total = 10
        let current = percent
        let width :CGFloat = 3.0
        let reducer :CGFloat = 0.000
        let circlePath = UIBezierPath(arcCenter: CGPoint (x: self.frame.size.width / 2, y: self.frame.size.height / 2),
                                      radius: self.frame.size.width / 2,
                                      startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi),
                                      clockwise: true)
        let multiplier = CGFloat((100.000 / Double(total)) * 0.0100)
        
        for i in 1...total {

            let circleShape = CAShapeLayer()
            circleShape.path = circlePath.cgPath
            let color = goodAverrage ? #colorLiteral(red: 0.3921568627, green: 0.8156862745, blue: 0.5137254902, alpha: 1).cgColor : #colorLiteral(red: 0.862745098, green: 0.8745098039, blue: 0.337254902, alpha: 1).cgColor
            let colorAlpha = goodAverrage ? #colorLiteral(red: 0.3921568627, green: 0.8156862745, blue: 0.5137254902, alpha: 1).withAlphaComponent(0.4).cgColor : #colorLiteral(red: 0.862745098, green: 0.8745098039, blue: 0.337254902, alpha: 1).withAlphaComponent(0.4).cgColor
            circleShape.strokeColor = Double(i) <= current ?? 0.0 ? color : colorAlpha

            circleShape.fillColor = UIColor.clear.cgColor
            circleShape.lineWidth = width
            circleShape.strokeStart = CGFloat(CGFloat(i - 1) * multiplier) + reducer
            circleShape.strokeEnd = CGFloat(CGFloat(i) * multiplier) - reducer
            self.layer.addSublayer(circleShape)
        }
    }
}

