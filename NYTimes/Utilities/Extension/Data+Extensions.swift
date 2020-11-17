//
//  Data+Extensions.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

/// This is the parsing of json 
extension Data {
    func getJson(options:JSONSerialization.ReadingOptions? = nil) throws -> [String: Any]  {
        let options = options ?? JSONSerialization.ReadingOptions(rawValue: 0)
        guard let dictData = try JSONSerialization.jsonObject(with: self, options: options) as? [String:Any] else {
            return [:]
        }
        return dictData
    }
}
