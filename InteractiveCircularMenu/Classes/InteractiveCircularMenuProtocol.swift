//
//  Protocol.swift
//  InteractiveCircularMenu
//
//  Created by CatchZeng on 2018/11/9.
//

import Foundation
import UIKit

public typealias CircularMenuItem = UIView

public protocol InteractiveCircularMenuDataSource: class {
    func numberOfItems(in menu: InteractiveCircularMenu) -> Int
    func menu(_ menu: InteractiveCircularMenu, itemAt index: Int) -> CircularMenuItem
}

@objc public protocol InteractiveCircularMenuDelegate: class {
    func menu(_ menu: InteractiveCircularMenu, didSelectAt index: Int)
    func menu(_ menu: InteractiveCircularMenu, itemSizeAt index: Int) -> CGSize
    func circularWidth(in menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func speedRatio(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func startAngleOffset(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func spacingAngle(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func maxAngle(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func minAngle(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func minSpringbackAngle(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func maxSpringbackAngle(_ menu: InteractiveCircularMenu) -> CGFloat
}
