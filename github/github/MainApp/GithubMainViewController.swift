//
//  GithubMainViewController.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import RxDataSources

class GithubMainViewController : BaseViewController {
    private var searchBar = UISearchBar()
    private var tableView = UITableView()
    
    private var viewModel: GithubMainViewModel? {
        return baseViewModel as? GithubMainViewModel
    }

    private func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        
        searchBar.keyboardAppearance = .dark
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        
        searchBar.backgroundColor = GithubColors.Main.searchBarBkg
        searchBar.tintColor = GithubColors.Main.searchBarText
        searchBar.barTintColor = GithubColors.Main.searchBarBkg
        searchBar.setImage(UIImage(named: "search_icon_dark"), for: .search, state: .normal)
        
        searchBar.searchTextField.font = GithubFonts.Main.searchText
        searchBar.searchTextField.textColor = GithubColors.Main.searchBarText
        searchBar.searchTextField.tintColor = GithubColors.Main.searchBarText
        searchBar.searchTextField.backgroundColor = GithubColors.Main.searchBarTextFieldBkg
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = GithubColors.Main.searchBarTextFieldFrame.cgColor
        searchBar.searchTextField.layer.cornerRadius = 10

        navigationItem.titleView = searchBar
        self.searchBar = searchBar
    }
    
    private func setupMainView() {
        navigationController?.setStatusBar(backgroundColor: GithubColors.Main.searchBarBkg)
        view.backgroundColor = GithubColors.Main.background
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = GithubColors.Main.searchBarBkg
    }
    
    private func setupTable() {
        let tableView = UITableView()
        tableView.backgroundColor = GithubColors.Main.background
        tableView.separatorColor = GithubColors.Table.separator
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        view.addSubview(tableView)
        
        self.tableView = tableView
    }
    
    override func setupUI() {
        setupMainView()
        setupSearchBar()
        setupTable()
    }
    
    override func setupConstraints() {
        self.tableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupBindings() {
        let dataSource = RxTableViewSectionedReloadDataSource<GitHubSection>(configureCell: { (dataSource, tableView, indexPath, cellViewModel) -> UITableViewCell in
            let cell = UITableViewCell()
            cell.textLabel?.text = cellViewModel.repoItem.name
            return cell
        })
        
        viewModel?.searchResult().flatMapLatest({ searchResult -> Observable<[GitHubSection]> in
            let cellViewModels = searchResult.items?.map({ item in
                GithubMainCellViewModel(repoItem: item)
            }) ?? []
            return Observable.just([GitHubSection(model: "", items: cellViewModels)])
            }).bind(to: self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        searchBar.rx.text.skip(1)
            .distinctUntilChanged()
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .startWith("githubsearch")
            .subscribe(onNext: {[weak self] text in
                guard let self = self else {return}
                self.viewModel?.search(text ?? "")
            }).disposed(by: disposeBag)
    }
}

typealias GitHubSection = SectionModel<String, GithubMainCellViewModel>
