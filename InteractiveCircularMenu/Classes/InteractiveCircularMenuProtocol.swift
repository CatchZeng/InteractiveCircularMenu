//
//  Protocol.swift
//  InteractiveCircularMenu
//
//  Created by CatchZeng on 2018/11/9.
//

import Foundation
import UIKit

@objc public protocol InteractiveCircularMenuDataSource: class {
    func numberOfItems(in menu: InteractiveCircularMenu) -> Int
    func menu(_ menu: InteractiveCircularMenu, itemAt index: Int) -> UIButton
    func menu(_ menu: InteractiveCircularMenu, itemSizeAt index: Int) -> CGSize
    func circularWidth(in menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func speedRatio(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func startAngleOffset(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func spacingAngle(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func maxAngle(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func minAngle(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func minSpringBackAngle(_ menu: InteractiveCircularMenu) -> CGFloat
    @objc optional func maxSpringBackAngle(_ menu: InteractiveCircularMenu) -> CGFloat
}

public protocol InteractiveCircularMenuDelegate: class {
    func menu(_ menu: InteractiveCircularMenu, didSelectAt index: Int)
}
