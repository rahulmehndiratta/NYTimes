//
//  Parsable.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

/*
* It is a protocall which i have used for data parsing to provide Generic effect for responses
*/
protocol Parsable {
    init?(withJSON json: [String: Any])
}
