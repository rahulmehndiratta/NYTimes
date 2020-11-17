//
//  NYNewsListViewModel.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class NYNewsListViewModel: NSObject {
    
    private var isDataReady: Observable<Bool>
    private var error: Observable<APIError>
    private var newsList: [NYNewsListModel]?
    
    override init() {
        isDataReady = Observable<Bool>()
        error = Observable<APIError>()
        super.init()
    }
    
    //MARK: Binding View with view model
    func bindSuccess(listner: @escaping Listner<Bool>) {
        self.isDataReady.bind(listner: listner)
    }
    
    func bindFailure(listner: @escaping Listner<APIError>) {
        self.error.bind(listner: listner)
    }
    
    func sendPopularNewsRequest() {
        NetworkManager.shared.sendRequest(atPoint: APIPints.mostPopularList, parameters: nil) {[weak self] (response: NetworkResponse<[NYNewsListModel]>) in
            DispatchQueue.main.async {
                switch response.resultType {
                case .failure(let error):
                    self?.error.value = error
                case .success(let newsList):
                    self?.newsList = newsList
                    self?.isDataReady.value = true
                }
            }
        }
    }
    
    //MARK: Table View Data related Methods
    func numberOfRows(inSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func item(atIndexPath indexPath: IndexPath) -> NYNewsListModel? {
        return newsList?[indexPath.row]
    }
}

