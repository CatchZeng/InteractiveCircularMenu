//
//  ViewController.swift
//  InteractiveCircularMenu
//
//  Created by catchzeng on 11/09/2018.
//  Copyright (c) 2018 catchzeng. All rights reserved.
//

import UIKit
import InteractiveCircularMenu

class ViewController: UIViewController {

    var items: [CircularMenuItem] = [CircularMenuItem]()

    @IBOutlet weak var menuView: InteractiveCircularMenu!

    override func viewDidLoad() {
        super.viewDidLoad()
        items = [createItems(number: 1),
        createItems(number: 2),
        createItems(number: 3),
        createItems(number: 4),
        createItems(number: 5),
        createItems(number: 6),
        createItems(number: 7),
        createItems(number: 8),
        createItems(number: 9),
        createItems(number: 10),
        createItems(number: 11),
        createItems(number: 12),
        createItems(number: 13),
        createItems(number: 14),
        createItems(number: 15),
        createItems(number: 16),
        createItems(number: 17)]

        menuView.dataSource = self
        menuView.delegate = self
        menuView.menuColor = UIColor.white
    }

    private func createItems(number: Int) -> CircularMenuItem {
        let value = number%4
        let item = UIImageView(image: UIImage(named: "l\(value)"))
        item.contentMode = .scaleAspectFit
        return item
    }
}

extension ViewController: InteractiveCircularMenuDataSource {
    func numberOfItems(in menu: InteractiveCircularMenu) -> Int {
        return items.count
    }

    func menu(_ menu: InteractiveCircularMenu, itemAt index: Int) -> CircularMenuItem {
        return items[index]
    }

    func circularWidth(in menu: InteractiveCircularMenu) -> CGFloat {
        return 80
    }

    func menu(_ menu: InteractiveCircularMenu, itemSizeAt index: Int) -> CGSize {
        let width = circularWidth(in: menu)
        return CGSize(width: width*0.9, height: width*0.9)
    }

    func startAngleOffset(_ menu: InteractiveCircularMenu) -> CGFloat {
        return 60
    }

    func spacingAngle(_ menu: InteractiveCircularMenu) -> CGFloat {
        return 30
    }

    func maxAngle(_ menu: InteractiveCircularMenu) -> CGFloat {
        return startAngleOffset(menu) + 2*spacingAngle(menu)
    }

    func minAngle(_ menu: InteractiveCircularMenu) -> CGFloat {
        let offset = startAngleOffset(menu)
        let spacing = spacingAngle(menu)
        return offset-spacing*CGFloat(items.count-1)
    }
}

extension ViewController: InteractiveCircularMenuDelegate {
    func menu(_ menu: InteractiveCircularMenu, didSelectAt index: Int) {
        AlertControllerBuilder(title: "Tip",
                               message: "Click:\(index+1)").addAction(title: "OK") { (_) in
        }.build().show()
    }
}
