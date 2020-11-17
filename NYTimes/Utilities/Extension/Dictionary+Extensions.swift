//
//  Dictionary+Extensions.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

/// This is the parsing of json elements where key must be string and value can be anything
extension Dictionary where Key == String ,Value == Any {
    func parse<T:Parsable>(parsable:T.Type) -> T? {
        return T(withJSON: self)
    }
}
