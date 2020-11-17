//
//  NetworkContants.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation


let WEB_SERVICE_URL = "http://api.nytimes.com"
let PERIOD = 7
let API_KEY = "AGw6y9FKxAvQPZgxLubymjoSvfhkmARI"
struct APIPints {
    static var mostPopularList = "/svc/mostpopular/v2/viewed/\(PERIOD).json?api-key=\(API_KEY)"
}
