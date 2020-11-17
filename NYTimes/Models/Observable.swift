//
//  Observable.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

typealias Listner<T> = (T)->Void

/// This is the property observer which is used to bind view and viewModels
class Observable<T> {
    
    var value: T? {
        willSet {
            if let newVal = newValue {
                listner?(newVal)
            }
        }
    }
    
    var listner: Listner<T>?
    func bind(listner: @escaping Listner<T>) {
        self.listner = listner
    }
}
