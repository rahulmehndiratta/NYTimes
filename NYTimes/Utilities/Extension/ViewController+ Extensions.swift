//
//  ViewController+ Extensions.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

extension UIViewController{
    func showProgressView(onWindow: Bool) {
        let frame = onWindow ? UIScreen.main.bounds : view.bounds
        let progressView = ProgressView(frame: frame)
        onWindow ? UIApplication.shared.windows.first { $0.isKeyWindow }?.addSubview(progressView) : view.addSubview(progressView)
    }
    
    func hideProgressView() {
        DispatchQueue.main.async { [weak self] in
            if let progressView = self?.view.subviews.first(where: { $0.isKind(of: ProgressView.self)}) {
                progressView.removeFromSuperview()
            } else if let progressView = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.subviews.first(where: { $0.isKind(of: ProgressView.self)})  {
                progressView.removeFromSuperview()
            }
        }
    }
}
