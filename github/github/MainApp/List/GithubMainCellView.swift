//
//  GithubMainCellView.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class GithubMainCellView: UITableViewCell {
    
    private let viewModel = PublishSubject<GithubMainCellViewModel>()
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(cellViewModel: GithubMainCellViewModel) {
        self.viewModel.onNext(cellViewModel)
    }
    
    private func setupUI() {
        backgroundColor = GithubColors.Table.cellBkg
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupBindings() {
        viewModel.subscribe(onNext: {[weak self] vm in
            guard let self = self else {return}
            self.textLabel?.text = vm.repoItem.name
            }).disposed(by: disposeBag)
    }
}
