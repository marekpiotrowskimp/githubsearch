//
//  GithubMainCellViewModel.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import RxSwift
import RxRelay

class GithubMainCellViewModel: BaseViewModel {
    
    let repoItem : RepoItem
    let provider : GithubImageProtocol
    
    init(repoItem: RepoItem, provider: GithubImageProtocol = GithubImageProvider.shard) {
        self.repoItem = repoItem
        self.provider = provider
    }

}
