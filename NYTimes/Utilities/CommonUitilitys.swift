//
//  CommonUitilitys.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class AppUtility {
    class func showAlert(withError error: APIError, buttonTitle: String) {
        let alert = UIAlertController(title: error.title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        
        getRootCtrl()?.present(alert, animated: true, completion: nil)
    }
    
    class func actionController(type: UIAlertController.Style, title: String?, message: String?, buttons: [(String?, UIAlertAction.Style, ((UIAlertAction) -> ())?)]) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: type)
        for button in buttons {
            alert.addAction(UIAlertAction(title: button.0, style: button.1, handler: button.2))
        }
        getRootCtrl()?.present(alert, animated: true, completion: nil)
    }
    
    class func getRootCtrl() -> UIViewController? {
        var ctrl = UIApplication.shared.keyWindow?.rootViewController
        while ctrl?.presentedViewController != nil {
            ctrl = ctrl?.presentedViewController
        }
        return ctrl
    }
}


