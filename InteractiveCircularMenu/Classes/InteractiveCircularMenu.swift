//
//  InteractiveCircularMenu.swift
//  InteractiveCircularMenu
//
//  Created by CatchZeng on 2018/11/9.
//

import Foundation
import UIKit

open class InteractiveCircularMenu: UIView {
    public weak var dataSource: InteractiveCircularMenuDataSource?
    public weak var delegate: InteractiveCircularMenuDelegate?
    public var menuColor = UIColor(red: 41/255, green: 128/255, blue : 185/255, alpha: 1.0) {
        didSet {
            setNeedsDisplay()
        }
    }
    public var circularWidth: CGFloat = 80 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private let itemsContainerView = UIView()
    private let circularLayer = CAShapeLayer()
    private var originRotation: CGFloat = 0.0
    private var originPoint = CGPoint()

    open override func draw(_ rect: CGRect) {
        addCircular()
        addItemsContainerView()
        addGesture()
        addItems()
    }
    
    private func addGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        addGestureRecognizer(panGesture)
    }
    
    @objc private func panAction(_ recognizer: UIPanGestureRecognizer) {
        let items = getItems()
        guard items.count > 0 else { return }
        
        switch recognizer.state {
        case .began:
            originPoint = recognizer.location(in: self)
            for item in items {
                item.isUserInteractionEnabled = false
            }
            
        case .changed:
            for item in items {
                item.isUserInteractionEnabled = false
            }
            let changeX = recognizer.location(in: self).x - originPoint.x
            placeItems(dX: changeX)
            originPoint = recognizer.location(in: self)
            
        case .ended:
            for item in items {
                item.isUserInteractionEnabled = true
            }
            break
        default:
            break
        }
    }
    
    private func addItems() {
        guard let itemCount = dataSource?.numberOfItems(in: self), itemCount > 0
            else {
            return
        }
        
        var items: [UIButton] = [UIButton]()
        for i in 0..<itemCount {
            if let item = dataSource?.menu(self, itemAt: i), let size = dataSource?.menu(self, itemSizeAt: i) {
                items.append(item)
                
                item.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                item.tag = i
                item.addTarget(self, action: #selector(onItemClicked(_:)), for: .touchUpInside)
                itemsContainerView.addSubview(item)
            }
        }
        
        placeItems(items)
    }
    
    @objc func onItemClicked(_ sender: UIButton){
        delegate?.menu(self, didSelectAt: sender.tag)
    }
    
    private func placeItems(dX: CGFloat) {
        let value = originRotation + dX/100.0
        let angle = transformToAngle(rotation: value)
        if let maxAngle = dataSource?.maxAngle(self), let offset = dataSource?.startAngleOffset(self), angle > (maxAngle-offset) {
            return
        }
        
        if let minAngle = dataSource?.minAngle(self), let offset = dataSource?.startAngleOffset(self), angle < (minAngle-offset) {
            return
        }
        
        print("angle: \(angle)")
        originRotation = value
        itemsContainerView.transform = CGAffineTransform(rotationAngle: originRotation)
        for item in getItems() {
            item.transform = CGAffineTransform(rotationAngle: -originRotation)
        }
    }
    
    private func transformToAngle(rotation: CGFloat) -> CGFloat {
        return rotation*(180.0/CGFloat.pi)
    }
    
    private func placeItems(_ items: [UIButton]) {
        let width = frame.size.width
        originRotation = 0
        
        for i in 0..<items.count {
            let radius = width/2 - circularWidth/2
            let offset = Double(dataSource?.startAngleOffset(self) ?? 0)/180.0*Double.pi
            let spacing = Double(dataSource?.spacingAngle(self) ?? 0)/180.0*Double.pi
            let angle = Double.pi + Double(i)*spacing + offset
            
            let xx = cos(angle) * Double(radius)
            let yy = sin(angle) * Double(radius)
            
            let item = items[i]
            item.center = CGPoint(x: xx,y: yy)
            item.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
    
    fileprivate func getItems() -> [UIButton] {
        guard let itemCount = dataSource?.numberOfItems(in: self), itemCount > 0
            else {
                return []
        }
        
        var items: [UIButton] = [UIButton]()
        for i in 0..<itemCount {
            if let item = dataSource?.menu(self, itemAt: i) {
                items.append(item)
            }
        }
        return items
    }
    
    private func addCircular() {
        circularLayer.frame = bounds
        
        let width = frame.size.width
        let height = frame.size.height
        
        menuColor.set()
        
        let path = UIBezierPath()
        path.lineWidth = 1.0
        path.move(to: CGPoint(x: 0, y: height))
        path.addArc(withCenter: CGPoint(x: width/2, y: height),
                    radius: width/2,
                    startAngle: CGFloat(Double.pi),
                    endAngle: 0,
                    clockwise: true)
        path.addLine(to: CGPoint(x: width-circularWidth, y: height))
        path.addArc(withCenter: CGPoint(x: width/2, y: height),
                    radius: width/2-circularWidth,
                    startAngle: 0,
                    endAngle: CGFloat(Double.pi),
                    clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: height))
        
        path.fill()
        path.close()
        
        circularLayer.path = path.cgPath
        circularLayer.fillColor = UIColor.clear.cgColor
        circularLayer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(circularLayer)
    }
    
    private func addItemsContainerView() {
        let width = frame.size.width
        let height = frame.size.height
        
        itemsContainerView.frame = CGRect(x: 0, y: 0, width: width, height: height*2)
        itemsContainerView.backgroundColor = UIColor.clear
        itemsContainerView.layer.cornerRadius = width / 2
        addSubview(itemsContainerView)
        itemsContainerView.bounds = CGRect(x: -width/2, y: -height, width: width, height: height*2)
    }
}
