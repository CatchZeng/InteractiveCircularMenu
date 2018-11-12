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
        
        let button6 = UIButton()
        button6.setTitle("6", for: .normal)
        button6.backgroundColor = UIColor.red
        
        let button7 = UIButton()
        button7.setTitle("7", for: .normal)
        button7.backgroundColor = UIColor.red
        
        let button8 = UIButton()
        button8.setTitle("8", for: .normal)
        button8.backgroundColor = UIColor.red
        
        let button9 = UIButton()
        button9.setTitle("9", for: .normal)
        button9.backgroundColor = UIColor.red
        
        let button10 = UIButton()
        button10.setTitle("10", for: .normal)
        button10.backgroundColor = UIColor.red
        
        items = [button1, button2, button3, button4, button5, button6, button7, button8, button9, button10]
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
    
    func spacingAngle(_ menu: InteractiveCircularMenu) -> CGFloat {
        return 50
    }
}

extension ViewController: InteractiveCircularMenuDelegate {
    func menu(_ menu: InteractiveCircularMenu, didSelectAt index: Int) {
        AlertControllerBuilder(title: "提示", message: "点击了:\(index+1)").addAction { (action) in
            
        }.build().show()
    }
}

