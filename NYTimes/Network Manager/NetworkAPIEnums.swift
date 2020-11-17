//
//  NetworkAPIEnums.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
enum APIError: Error {
    case noInternet, requestFailure(message: String), other
    
    var localizedDescription: String {
        switch self {
        case .noInternet:
            return Strings.NO_INTERNET
        case .requestFailure(let message):
            return message
        case .other:
            return Strings.SOMETHING_WRONG
        }
    }
    
    var title: String {
        switch self {
        case .noInternet:
            return Strings.NETWORK_ERROR_TITLE
        case .requestFailure(_):
            return Strings.REQUEST_REQUEST
        case .other:
            return Strings.ERROR_ALERT
        }
    }
}


enum HTTPMethods: String {
    case post = "POST", get = "GET"
}

