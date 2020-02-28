//
//  BaseViewController.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let baseViewModel : BaseViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: BaseViewModel) {
        self.baseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
