//
//  MasterTableViewController.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {

    private var loadingIndicator = UIActivityIndicatorView()
    private var cityListViewPresenter: CitiesViewPresenter!
    private var datasource: TableViewDataSource<CityCell, City>!
    let cellIdentifier: String = "CityCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator = UIActivityIndicatorView(style: .gray)
        searchBar.delegate = self
        cityListViewPresenter = CitiesViewPresenter.init(view: self, model: CitiesListModel())
        tableView.tableFooterView = UIView()
        setupTableViewDataSource()
        setupNavigationBar()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    func setupNavigationBar() {
        self.title = ViewTitles.cititlsListViewTitle
    }
    
    func setupTableViewDataSource() {
        self.datasource = TableViewDataSource(cellIdentifier: self.cellIdentifier, viewPresnter: self.cityListViewPresenter) { cell, vm in
            cell.configure(vm)
        }
        self.tableView.dataSource = self.datasource
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//SearchDelegate
extension CitiesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else{ return }
                self.searchBar.resignFirstResponder()
            }
        }
        cityListViewPresenter.searchForCitiesContains(searchText)
    }
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//ViewDelegate
extension CitiesListViewController: BaseViewProtocol {
    func setupViewData() {
        self.tableView.reloadData()
    }
    func setupErrorHandling(error: ModelError) {
        setupAlertView(view: self, title: "Error", message: error.errorDescription ?? ErrorDescreption.defaultErrorMessage, buttonTitle: "Close")
    }
    func setActivityIndicator(hidden: Bool) {
        let centerPoint = CGPoint(x: view.frame.width / 2, y: tableView.contentOffset.y + view.frame.height / 2)
        setupActivityIndicator(view: view, hidden: hidden, loadingIndicator: loadingIndicator, centerPoint: centerPoint)
    }
}
