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
    private let stars = UILabel()
    private let userContainer = UserView()
    
    private let margin = 10
    private let marginLeft = 25
    private let userWidth = 64
    
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
    
    private func setupSelection() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = GithubColors.Table.cellHighlight
        bgColorView.layer.masksToBounds = true
        self.selectedBackgroundView = bgColorView
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
        prepareLabel(label: stars)
        addSubview(userContainer)
        setupSelection()
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
        
        stars.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(marginLeft)
            make.top.equalTo(licence.snp.bottom)
            make.bottom.equalToSuperview().inset(margin)
        }
        
        userContainer.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(marginLeft)
            make.bottom.equalToSuperview().inset(margin)
            make.top.equalToSuperview().offset(margin)
            make.width.equalTo(userWidth)
        }
    }
    
    private func fillCell(_ vm :GithubMainCellViewModel) {
        let item: RepoItem = vm.repoItem
        userContainer.clearView()
        name.text = item.name
        fullName.text = item.fullName
        language.text = "Language: \(item.language ?? "")"
        branch.text = "Default: \(item.defaultBranch ?? "")"
        licence.text = item.license?.name
        userContainer.fillUserInformation(user: item.owner)
        stars.text = "Stars: \(item.stargazersCount ?? 0)"
        
        if let imageUrl = item.owner?.avatarURL {
            vm.provider.fetchImage(url: imageUrl).subscribe(onNext:{[weak self] image in
                self?.userContainer.setImageForUser(image)
            }).disposed(by: disposeBag)
        }
    }
    
    private func setupBindings() {
        viewModel.subscribe(onNext: {[weak self] vm in
            guard let self = self else {return}
            self.fillCell(vm)
        }).disposed(by: disposeBag)
    }
}
