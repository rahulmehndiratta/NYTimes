//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import SystemConfiguration

//NOTE: I have just made one methods because of less time and less requirements.

typealias Response<T: Parsable> = (NetworkResponse<T>) -> Void

class NetworkManager {
    static let shared = NetworkManager()
    
    
    private var isNetWorkAvailable:  Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    private init() {
        
    }
    
    //MARK: Request Methods
    func sendRequest<T: Parsable>(atPoint point: String, method: HTTPMethods = .get, parameters: [String: Any]?, responseCallback: @escaping Response<T>) {
        guard isNetWorkAvailable else {
            responseCallback(NetworkResponse<T>(json: [:], result: .failure(.noInternet)))
            return
        }
        guard let url = URL(string: WEB_SERVICE_URL + point) else {
            responseCallback(NetworkResponse<T>(json: [:], result: .failure(.other)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let params = parameters, !params.isEmpty && method == .post {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = bodyData
            } catch {
                print(error.localizedDescription)
            }
        }
        //NOTE: we can add query string from parameters if type is get but i don not have time fo that
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                responseCallback(NetworkResponse<T>.init(json: [:], result: .failure(.requestFailure(message: error.localizedDescription))))
                return
            } else if let data = data {
                do {
                    let json = try data.parseData()
                    if json.keys.contains("fault") {
                        responseCallback(NetworkResponse<T>.init(json: [:], result: .failure(.requestFailure(message: Strings.SERVER_KEY_ERROR))))
                        return
                        
                    }
                    guard !json.isEmpty, let parsed: T = json.parse(parsable: T.self) else {
                        responseCallback(NetworkResponse<T>.init(json: [:], result: .failure(.requestFailure(message: APIError.other.localizedDescription))))
                        return
                    }
                    let response = NetworkResponse<T>.init(json: json, result: .success(parsed))
                    responseCallback(response)
                } catch {
                    responseCallback(NetworkResponse<T>.init(json: [:], result: .failure(.requestFailure(message: error.localizedDescription))))
                }
            } else {
                responseCallback(NetworkResponse<T>.init(json: [:], result: .failure(.requestFailure(message: APIError.other.localizedDescription))))
                return
            }
        }
        task.resume()
    }
    
    
}

