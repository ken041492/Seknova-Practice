//
//  HistoryViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/2.
//

import UIKit

class HistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupCircle()
        
    }

    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * .pi / 180
    }
    
    func setupCircle() -> UIView {
        
        let aDegree = Double.pi / 180
        let lineWidth: Double = 10
        let radius: Double = 20
        var startDegree: Double = 270
        let viewWidth = 2 * (radius + lineWidth)

        let center = CGPoint(x: lineWidth + radius, y: lineWidth + radius)
        
        // 创建一个容器视图，用于包含所有的图层
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth))
        
        // 创建外部圆圈
        let outerCirclePath = UIBezierPath(arcCenter: center, radius: CGFloat(radius + 1), startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        let outerCircleLayer = CAShapeLayer()
        outerCircleLayer.path = outerCirclePath.cgPath
        outerCircleLayer.strokeColor = UIColor.black.cgColor
        outerCircleLayer.lineWidth = lineWidth
        outerCircleLayer.fillColor = UIColor.clear.cgColor
//        view.layer.addSublayer(outerCircleLayer)
        containerView.layer.addSublayer(outerCircleLayer)

        let endDegree = startDegree + 360 * 50 / 100
        let percentagePath = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
        let percentageLayer = CAShapeLayer()
        percentageLayer.path = percentagePath.cgPath
        percentageLayer.strokeColor = UIColor.green.cgColor
        percentageLayer.lineWidth = lineWidth
        percentageLayer.fillColor = UIColor.clear.cgColor
//        view.layer.addSublayer(percentageLayer)
        containerView.layer.addSublayer(percentageLayer)

        
        startDegree = endDegree

        let endDegree2 = startDegree + 360 * 50 / 100
        let percentagePath2 = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: aDegree * startDegree, endAngle: aDegree * endDegree2, clockwise: true)
        let percentageLayer2 = CAShapeLayer()
        percentageLayer2.path = percentagePath2.cgPath
        percentageLayer2.strokeColor = UIColor.gray.cgColor
        percentageLayer2.lineWidth = lineWidth
        percentageLayer2.fillColor = UIColor.clear.cgColor
//        view.layer.addSublayer(percentageLayer2)
        containerView.layer.addSublayer(percentageLayer2)
        startDegree = endDegree2
        // 创建內部圆圈
        let interCirclePath = UIBezierPath(arcCenter: center, radius: CGFloat((lineWidth + radius) / 2), startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        let interCircleLayer = CAShapeLayer()
        interCircleLayer.path = interCirclePath.cgPath
        interCircleLayer.strokeColor = UIColor.black.cgColor
        interCircleLayer.lineWidth = 1
        interCircleLayer.fillColor = UIColor.clear.cgColor
//        view.layer.addSublayer(interCircleLayer)
        containerView.layer.addSublayer(interCircleLayer)
        
        // 计算分界线的结束点坐标
        let dividerLength = CGFloat(lineWidth / 2)  // 分界线长度
        let dividerX = center.x
        let dividerY = center.y - radius - lineWidth / 2

        // 创建分界线
        let dividerPath = UIBezierPath()
        dividerPath.move(to: CGPoint(x: dividerX, y: dividerY + lineWidth)) // 起点
        dividerPath.addLine(to: CGPoint(x: dividerX, y: dividerY)) // 终点

        let dividerLayer = CAShapeLayer()
        dividerLayer.path = dividerPath.cgPath
        dividerLayer.strokeColor = UIColor.black.cgColor
        dividerLayer.lineWidth = 2
        dividerLayer.fillColor = UIColor.clear.cgColor
//        view.layer.addSublayer(dividerLayer)
        containerView.layer.addSublayer(dividerLayer)
        
        // 计算分界线的结束点坐标

        let dividerY1 = center.y + radius + lineWidth / 2

        // 创建分界线
        let dividerPath1 = UIBezierPath()
        dividerPath1.move(to: CGPoint(x: dividerX, y: dividerY1 - lineWidth)) // 起点
        dividerPath1.addLine(to: CGPoint(x: dividerX, y: dividerY1)) // 终点

        let dividerLayer1 = CAShapeLayer()
        dividerLayer1.path = dividerPath1.cgPath
        dividerLayer1.strokeColor = UIColor.black.cgColor
        dividerLayer1.lineWidth = 2
        dividerLayer1.fillColor = UIColor.clear.cgColor
//        view.layer.addSublayer(dividerLayer1)
        containerView.layer.addSublayer(dividerLayer1)
        
        return containerView
    }
}
