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
    
    var items:[UIButton] = [UIButton]()

    @IBOutlet weak var menuView: InteractiveCircularMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [createButton(no: 1),
        createButton(no: 2),
        createButton(no: 3),
        createButton(no: 4)]
//        createButton(no: 5),
//        createButton(no: 6),
//        createButton(no: 7),
//        createButton(no: 8),
//        createButton(no: 9),
//        createButton(no: 10),
//        createButton(no: 11),
//        createButton(no: 12),
//        createButton(no: 13),
//        createButton(no: 14),
//        createButton(no: 15),
//        createButton(no: 16),
//        createButton(no: 17),
//        createButton(no: 18),
//        createButton(no: 19),
//        createButton(no: 20),
//        createButton(no: 21),
//        createButton(no: 22),
//        createButton(no: 23)]
        menuView.dataSource = self
        menuView.delegate = self
        menuView.menuColor = UIColor.white
    }
    
    private func createButton(no: Int) -> UIButton {
        let button = UIButton()
        button.setTitle("\(no)", for: .normal)
        button.setImage(UIImage(named: "l\(no)"), for: .normal)
        return button
    }
}

extension ViewController: InteractiveCircularMenuDataSource {
    func circularWidth(in menu: InteractiveCircularMenu) -> CGFloat {
        return 80
    }
    
    func numberOfItems(in menu: InteractiveCircularMenu) -> Int {
        return items.count
    }
    
    func menu(_ menu: InteractiveCircularMenu, itemAt index: Int) -> UIButton {
        return items[index]
    }
    
    func menu(_ menu: InteractiveCircularMenu, itemSizeAt index: Int) -> CGSize {
        return CGSize(width: 75, height: 75)
    }
    
    func spacingAngle(_ menu: InteractiveCircularMenu) -> CGFloat {
        return 30
    }
    
    func startAngleOffset(_ menu: InteractiveCircularMenu) -> CGFloat {
        return 60
    }
    
    func maxAngle(_ menu: InteractiveCircularMenu) -> CGFloat {
        return 90
    }
    
    func minAngle(_ menu: InteractiveCircularMenu) -> CGFloat {
        return CGFloat(60-30*(items.count-2));
    }
}

extension ViewController: InteractiveCircularMenuDelegate {
    func menu(_ menu: InteractiveCircularMenu, didSelectAt index: Int) {
        AlertControllerBuilder(title: "提示", message: "点击了:\(index+1)").addAction { (action) in
            
        }.build().show()
    }
}

