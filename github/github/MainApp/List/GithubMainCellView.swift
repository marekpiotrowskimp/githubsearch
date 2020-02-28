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
    
    private let name = UILabel()
    private let fullName = UILabel()
    private let branch = UILabel()
    private let language = UILabel()
    private let licence = UILabel()
    private let score = UILabel()
    private let userContainer = UserView()
    
    private let margin = 10
    private let marginLeft = 25

    
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
        func prepareLabel(label: UILabel) {
            label.textColor = GithubColors.Table.cellText
            label.font = GithubFonts.Table.text
            label.adjustsFontSizeToFitWidth = true
            addSubview(label)
        }
        
        backgroundColor = GithubColors.Table.cellBkg
        name.textColor = GithubColors.Table.cellTitle
        name.font = GithubFonts.Table.name
        name.adjustsFontSizeToFitWidth = true
        addSubview(name)
        
        fullName.textColor = GithubColors.Table.cellFullTitle
        fullName.font = GithubFonts.Table.fullName
        fullName.adjustsFontSizeToFitWidth = true
        addSubview(fullName)

        prepareLabel(label: branch)
        prepareLabel(label: language)
        prepareLabel(label: licence)
        prepareLabel(label: score)
        addSubview(userContainer)
    }
    
    private func setupConstraints() {
        name.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(marginLeft)
            make.top.equalToSuperview().offset(margin)
            make.trailing.equalToSuperview().inset(marginLeft)
        }
        
        fullName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(marginLeft)
            make.trailing.equalToSuperview().inset(marginLeft)
            make.top.equalTo(name.snp.bottom)
        }
        
        language.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(marginLeft)
            make.trailing.equalToSuperview().inset(marginLeft)
            make.top.equalTo(fullName.snp.bottom)
        }
        
        branch.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(marginLeft)
            make.top.equalTo(language.snp.bottom)
        }
        
        licence.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(marginLeft)
            make.top.equalTo(branch.snp.bottom)
        }
        
        score.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(marginLeft)
            make.top.equalTo(licence.snp.bottom)
            make.bottom.equalToSuperview().inset(margin)
        }
        
        userContainer.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(marginLeft)
            make.bottom.equalToSuperview().inset(margin)
            make.width.equalTo(64)
            make.width.equalTo(96)
        }
    }
    
    private func fillCell(item: RepoItem) {
        name.text = item.name
        fullName.text = item.fullName
        language.text = "Language: \(item.language ?? "")"
        branch.text = "Default: \(item.defaultBranch ?? "")"
        licence.text = item.license?.name
        userContainer.fillUserInformation(user: item.owner)
        score.text = "Score: \(item.score ?? 0)"
        
    }
    
    private func setupBindings() {
        viewModel.subscribe(onNext: {[weak self] vm in
            guard let self = self else {return}
            self.fillCell(item: vm.repoItem)
            }).disposed(by: disposeBag)
    }
}
