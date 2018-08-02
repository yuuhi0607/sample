//
//  GitHubRepositoryListPresenterImpl.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Foundation
import Model
import RxSwift
import RxCocoa
import PresenterProtocol
import RouterProtocol
import UseCaseProtocol
import Logger

public class GitHubRepositoryListPresenterImpl: GitHubRepositoryListPresenter {
    public var models: BehaviorRelay<[RepositoryListCellModel]>
    
    private let useCase: GitHubRepositoryListUseCase
    private let router: GitHubRepositoryListRouter
    weak public var viewController: GitHubRepositoryListPresenterOutput?
    
    private let disposeBag = DisposeBag()
    
    public init(router: GitHubRepositoryListRouter, viewController: GitHubRepositoryListPresenterOutput, useCase: GitHubRepositoryListUseCase) {
        self.router = router
        self.viewController = viewController
        self.useCase = useCase
        
        self.models = self.useCase.models
    }
    
    public func viewDidLoad() {
        viewController?.showLoading()
        useCase.loadRepositoryList().subscribe(onSuccess: { [unowned self]() in
            self.viewController?.dismissLoading()
        }) { [unowned self](error) in
            Logger.presenterLogger.error(error)
            self.viewController?.dismissLoading()
            //VCへエラー発生を伝える
            self.viewController?.notifyError(error: error)
        }.disposed(by: disposeBag)
    }
    
    public func viewWillAppear() {
        //do nothing
    }

}
