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
    @objc optional func startAngleOffset(_ menu: InteractiveCircularMenu) -> Int
    @objc optional func spacingAngle(_ menu: InteractiveCircularMenu) -> Int
}

public protocol InteractiveCircularMenuDelegate: class {
    func menu(_ menu: InteractiveCircularMenu, didSelectAt index: Int)
}

extension InteractiveCircularMenuDataSource {
    func startAngleOffset(_ menu: InteractiveCircularMenu) -> Int {
        return 25
    }
    
    func spacingAngle(_ menu: InteractiveCircularMenu) -> Int {
        return 25
    }
}
