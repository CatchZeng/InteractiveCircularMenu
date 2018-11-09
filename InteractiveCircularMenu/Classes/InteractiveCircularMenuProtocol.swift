//
//  Protocol.swift
//  InteractiveCircularMenu
//
//  Created by CatchZeng on 2018/11/9.
//

import Foundation
import UIKit

public protocol InteractiveCircularMenuDataSource: class {
    func numberOfItems(in menu: InteractiveCircularMenu) -> Int
    func menu(_ menu: InteractiveCircularMenu, itemAt index: Int) -> UIButton
    func menu(_ menu: InteractiveCircularMenu, itemSizeAt index: Int) -> CGSize
}

public protocol InteractiveCircularMenuDelegate: class {
    func menu(_ menu: InteractiveCircularMenu, didSelectAt index: Int)
}
