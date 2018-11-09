//
//  AlertControllerBuilder.swift
//  AlertControllerBuilder
//
//  Created by CatchZeng on 2017/6/28.
//  Copyright © 2017年 catch. All rights reserved.
//

import UIKit

@objc open class AlertControllerBuilder: NSObject {
    private var alertController: UIAlertController
    
    @objc public init(title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert) {
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    }
    
    @objc public func setTitle(_ title: String) -> Self {
        alertController.title = title
        return self
    }
    
    @objc public func setMessage(_ message: String) -> Self {
        alertController.message = message
        return self
    }
    
    @objc public func addAction(title: String = "", style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Swift.Void)?) -> Self {
        alertController.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }
    
    @objc public func addTextFieldHandler(_ handler: @escaping ((UITextField) -> Void) = { _ in }) -> Self {
        alertController.addTextField(configurationHandler: handler)
        return self
    }
    
    @objc public func build() -> UIAlertController {
        return alertController
    }
}

// MARK: Show for UIAlertController
extension UIAlertController {
    @objc public func show(animated: Bool = true, completionHandler: (() -> Void)? = nil) {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        var forefrontVC = rootVC
        while let presentedVC = forefrontVC.presentedViewController {
            forefrontVC = presentedVC
        }
        forefrontVC.present(self, animated: animated, completion: completionHandler)
    }
}
