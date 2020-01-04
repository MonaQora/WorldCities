//
//  AboutViewController.swift
//  WorldCities
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    private var loadingIndicator = UIActivityIndicatorView()
    private var aboutPresenter: AboutPresenter!
    private var datasource: TableViewDataSource<AboutCell, AboutInfoUIData>!
    let cellIdentifier: String = "AboutCell"
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        aboutPresenter = AboutPresenter.init(view: self, model: AboutListModel())
        self.setupTableViewDataSource()
    }

    func setupTableViewDataSource() {
        self.datasource = TableViewDataSource(cellIdentifier: self.cellIdentifier, viewPresnter: self.aboutPresenter) { cell, vm in
            cell.configure(vm)
        }
        self.tableView.dataSource = self.datasource
    }
}

extension AboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//ViewDelegate
extension AboutViewController: BaseViewProtocol {
    func setupViewData() {
        self.tableView.reloadData()
    }
    
    func setupErrorHandling(error: ModelError) {
        setupAlertView(view: self, title: "Error", message: error.errorDescription ?? ErrorDescreption.defaultErrorMessage, buttonTitle: "Close")
    }
    
    func setActivityIndicator(hidden: Bool) {
        setupActivityIndicator(view: view, hidden: hidden, loadingIndicator: loadingIndicator)
    }

}

