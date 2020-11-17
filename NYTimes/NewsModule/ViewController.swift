//
//  ViewController.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = {return NYNewsListViewModel()}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettingsAtViewLoad()
    }
    
    private func initialSettingsAtViewLoad() {
        setupUIElements()
        setupNavigationBar()
        bindViewModel()
        showProgressView(onWindow: true)
        viewModel.sendPopularNewsRequest()
    }
    
    private func bindViewModel() {
        viewModel.bindSuccess { [weak self](success) in
            self?.hideProgressView()
            if success {
                self?.tableView.reloadData()
            }
        }
        viewModel.bindFailure { [weak self](error) in
            self?.hideProgressView()
            AppUtility.showAlert(withError: error, buttonTitle: Strings.OK)
        }
    }
    
    private func setupUIElements() {
        tableView.register(UINib(nibName: NYNewsTableCell.ID, bundle: nil), forCellReuseIdentifier: NYNewsTableCell.ID)
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        title = Strings.POPULAR_NEWS_VIEW_TITLE
        navigationController?.navigationBar.barTintColor = UIColor.navBarColor
        navigationController?.navigationBar.backgroundColor = UIColor.navBarColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.titleFont]
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NYNewsTableCell.ID, for: indexPath) as! NYNewsTableCell
        cell.populateData(news: self.viewModel.item(atIndexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

