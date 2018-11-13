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
    public var menuColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0) {
        didSet {
            reload()
        }
    }
    private let itemsContainerView = UIView()
    private let circularLayer = CAShapeLayer()
    private var originRotation: CGFloat = 0.0
    private var originPoint = CGPoint()
    private var originSize = CGSize.zero
    private var panGesture: UIPanGestureRecognizer?

    private var itemCount: Int {
        return dataSource?.numberOfItems(in: self) ?? 0
    }
    private var maxAngle: CGFloat {
        return delegate?.maxAngle?(self) ?? 180-spacingAngle
    }
    private var minAngle: CGFloat {
        let sCount = itemCount < 3 ? 0 : (itemCount-2)
        return delegate?.minAngle?(self) ?? -CGFloat(sCount)*spacingAngle
    }
    private var maxSpringBackAngle: CGFloat {
        return delegate?.maxSpringBackAngle?(self) ?? maxAngle-spacingAngle
    }
    private var minSpringBackAngle: CGFloat {
        return delegate?.minSpringBackAngle?(self) ?? minAngle+spacingAngle
    }
    private var spacingAngle: CGFloat {
        return delegate?.spacingAngle?(self) ?? 25
    }
    private var circularWidth: CGFloat {
        return delegate?.circularWidth(in: self) ?? 80
    }
    private var speedRatio: CGFloat {
        return delegate?.speedRatio?(self) ?? 1.0
    }
    private var startAngleOffset: CGFloat {
        return delegate?.startAngleOffset?(self) ?? 25
    }

    public func reload() {
        setNeedsDisplay()
    }

    open override func draw(_ rect: CGRect) {
        addCircular()
        addItemsContainerView()
        addGesture()
        addItems()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        if originSize != frame.size {
            originSize = frame.size
            reload()
        }
    }

    private func addGesture() {
        if panGesture == nil {
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
            panGesture?.minimumNumberOfTouches = 1
            panGesture?.maximumNumberOfTouches = 1
            addGestureRecognizer(panGesture!)
        }
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
            springBack()
            break
        default:
            break
        }
    }

    private func addItems() {
        var items: [CircularMenuItem] = [CircularMenuItem]()
        for i in 0..<itemCount {
            if let item = dataSource?.menu(self, itemAt: i), let size = delegate?.menu(self, itemSizeAt: i) {
                items.append(item)

                item.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                item.tag = i
                let tap = UITapGestureRecognizer(target: self, action: #selector(onItemClicked(_:)))
                item.addGestureRecognizer(tap)
                item.isUserInteractionEnabled = true
                itemsContainerView.addSubview(item)
            }
        }

        placeItems(items)
    }

    @objc func onItemClicked(_ recognizer: UIPanGestureRecognizer) {
        if let tag = recognizer.view?.tag {
            delegate?.menu(self, didSelectAt: tag)
        }
    }

    private func placeItems(dX: CGFloat) {
        let items = getItems()
        let value = originRotation + dX/100.0*speedRatio
        let angle = transformToAngle(rotation: value)
        if angle > (maxAngle-startAngleOffset) || angle < (minAngle-startAngleOffset) {
            return
        }

        originRotation = value
        itemsContainerView.transform = CGAffineTransform(rotationAngle: originRotation)
        for item in items {
            item.transform = CGAffineTransform(rotationAngle: -originRotation)
        }

        updateItemsVisibility(items: items)
    }

    private func springBack() {
        let angle = transformToAngle(rotation: originRotation)
        if angle > maxSpringBackAngle-startAngleOffset {
            let value = (maxSpringBackAngle-startAngleOffset)/180.0*CGFloat.pi
            doSpringbackAnimation(value)

        } else if angle < minSpringBackAngle-startAngleOffset {
            let value = (minSpringBackAngle-startAngleOffset)/180.0*CGFloat.pi
            doSpringbackAnimation(value)
        }
    }

    fileprivate func doSpringbackAnimation(_ value: CGFloat) {
        originRotation = value
        let items = self.getItems()
        UIView.animate(withDuration: 0.5) {
            self.itemsContainerView.transform = CGAffineTransform(rotationAngle: self.originRotation)
            for item in items {
                item.transform = CGAffineTransform(rotationAngle: -self.originRotation)
            }
        }
        updateItemsVisibility(items: items)
    }

    private func transformToAngle(rotation: CGFloat) -> CGFloat {
        return rotation*(180.0/CGFloat.pi)
    }

    private func placeItems(_ items: [CircularMenuItem]) {
        let width = frame.size.width
        originRotation = 0

        let radius = width/2 - circularWidth/2
        let offset = startAngleOffset/180.0*CGFloat.pi
        let spacing = spacingAngle/180.0*CGFloat.pi

        for i in 0..<items.count {
            let angle = .pi + CGFloat(i)*spacing + offset

            let xx = cos(angle) * radius
            let yy = sin(angle) * radius

            let item = items[i]
            item.center = CGPoint(x: xx, y: yy)
            item.transform = CGAffineTransform(rotationAngle: 0)
        }

        updateItemsVisibility(items: items)
    }

    private func addCircular() {
        circularLayer.removeFromSuperlayer()

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
        circularLayer.shadowOffset = CGSize(width: 1, height: 1)
        circularLayer.shadowOpacity = 0.8
        circularLayer.shadowColor = UIColor.black.cgColor
        circularLayer.shadowRadius = 4.0
        layer.addSublayer(circularLayer)
    }

    private func addItemsContainerView() {
        for item in getItems() {
            item.removeFromSuperview()
        }
        itemsContainerView.removeFromSuperview()

        let width = frame.size.width
        let height = frame.size.height

        itemsContainerView.frame = CGRect(x: 0, y: 0, width: width, height: height*2)
        itemsContainerView.backgroundColor = UIColor.clear
        itemsContainerView.layer.cornerRadius = width / 2
        addSubview(itemsContainerView)
        itemsContainerView.bounds = CGRect(x: -width/2, y: -height, width: width, height: height*2)
    }

    private func updateItemsVisibility(items: [CircularMenuItem]) {
        let angle = transformToAngle(rotation: originRotation)
        for i in 0..<items.count {
            let item = items[i]
            let placeAngle = startAngleOffset + CGFloat(i)*spacingAngle
            if angle>(-placeAngle-10) && angle<(180-placeAngle+10) {
                item.isHidden = false
            } else {
                item.isHidden = true
            }
        }
    }

    private func getItems() -> [CircularMenuItem] {
        if itemCount < 1 {
            return []
        }

        var items: [CircularMenuItem] = [CircularMenuItem]()
        for i in 0..<itemCount {
            if let item = dataSource?.menu(self, itemAt: i) {
                items.append(item)
            }
        }
        return items
    }
}
