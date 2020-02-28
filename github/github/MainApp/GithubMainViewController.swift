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
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let waitingIndicator = UIActivityIndicatorView(style: .large)
    private let noResults = UILabel()
    private let cellIdentifier = "githubcell"
    
    private var viewModel: GithubMainViewModel? {
        return baseViewModel as? GithubMainViewModel
    }

    private func setupSearchBar() {
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
    }
    
    private func setupMainView() {
        navigationController?.setStatusBar(backgroundColor: GithubColors.Main.searchBarBkg)
        view.backgroundColor = GithubColors.Main.background
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = GithubColors.Main.searchBarBkg
    }
    
    private func setupWaitingIndicatorAndMessage() {
        noResults.backgroundColor = GithubColors.Main.background
        noResults.textColor = GithubColors.Main.noResult
        noResults.font = GithubFonts.Main.noResult
        noResults.text = "No Search Results"
        noResults.textAlignment = .center
        noResults.isHidden = false
        view.addSubview(noResults)
        waitingIndicator.backgroundColor = GithubColors.Main.waitingBackground
        waitingIndicator.color = GithubColors.Main.waitingIndicator
        view.addSubview(waitingIndicator)
    }
    
    private func setupTable() {
        tableView.backgroundColor = GithubColors.Main.background
        tableView.separatorColor = GithubColors.Table.separator
        tableView.separatorStyle = .singleLine
        tableView.scrollsToTop = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        tableView.register(GithubMainCellView.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
    }
    
    override func setupUI() {
        setupMainView()
        setupSearchBar()
        setupTable()
        setupWaitingIndicatorAndMessage()
    }
    
    override func setupConstraints() {
        self.tableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        self.noResults.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.waitingIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func scrollToTop() {
        if tableView.numberOfSections > 0 && tableView.numberOfRows(inSection: 0) != 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    override func setupBindings() {
        let dataSource = RxTableViewSectionedReloadDataSource<GitHubSection>(configureCell: { [weak self] (dataSource, tableView, indexPath, cellViewModel) -> UITableViewCell in
            guard let self = self else { return UITableViewCell()}
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? GithubMainCellView
            cell?.setupCell(cellViewModel: cellViewModel)
            return cell ?? UITableViewCell()
        })
        
        viewModel?.searchResult()
            .do(onNext: { [weak self] sr in
                self?.noResults.isHidden = !(sr.items?.isEmpty ?? true)
            })
            .flatMapLatest({ searchResult -> Observable<[GitHubSection]> in
                let cellViewModels = searchResult.items?.map{GithubMainCellViewModel(repoItem: $0)} ?? []
                return Observable.just([GitHubSection(model: "", items: cellViewModels)])
            })
            .do(onNext: {[weak self] _ in
                self?.scrollToTop()
                self?.waitingIndicator.stopAnimating() })
            .bind(to: self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        searchBar.rx.text.skip(1)
            .distinctUntilChanged()
            .debounce(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)
            .do(onNext: { [weak self] _ in self?.searchBar.resignFirstResponder() })
            .startWith("githubsearch")
            .subscribe(onNext: {[weak self] text in
                guard let self = self else {return}
                self.waitingIndicator.startAnimating()
                self.viewModel?.search(text ?? "")
            }).disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(GithubMainCellViewModel.self)
            .subscribe(onNext: { selected in
                if let htmlURL = selected.repoItem.htmlURL,let url = URL(string: htmlURL) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }).disposed(by: disposeBag)
    }
}

typealias GitHubSection = SectionModel<String, GithubMainCellViewModel>
