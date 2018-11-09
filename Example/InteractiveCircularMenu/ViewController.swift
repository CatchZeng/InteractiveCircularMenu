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
        let button1 = UIButton()
        button1.setTitle("1", for: .normal)
        button1.backgroundColor = UIColor.red
        
        let button2 = UIButton()
        button2.setTitle("2", for: .normal)
        button2.backgroundColor = UIColor.red
        
        let button3 = UIButton()
        button3.setTitle("3", for: .normal)
        button3.backgroundColor = UIColor.red
        
        let button4 = UIButton()
        button4.setTitle("4", for: .normal)
        button4.backgroundColor = UIColor.red
        
        let button5 = UIButton()
        button5.setTitle("5", for: .normal)
        button5.backgroundColor = UIColor.red
        
        items = [button1, button2, button3, button4, button5]
        menuView.dataSource = self
        menuView.delegate = self
    }
}

extension ViewController: InteractiveCircularMenuDataSource {
    func numberOfItems(in menu: InteractiveCircularMenu) -> Int {
        return items.count
    }
    
    func menu(_ menu: InteractiveCircularMenu, itemAt index: Int) -> UIButton {
        return items[index]
    }
    
    func menu(_ menu: InteractiveCircularMenu, itemSizeAt index: Int) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
}

extension ViewController: InteractiveCircularMenuDelegate {
    func menu(_ menu: InteractiveCircularMenu, didSelectAt index: Int) {
        AlertControllerBuilder(title: "提示", message: "点击了:\(index+1)").addAction { (action) in
            
        }.build().show()
    }
}

