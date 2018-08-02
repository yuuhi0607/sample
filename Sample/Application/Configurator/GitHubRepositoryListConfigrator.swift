//
//  GitHubRepositoryListConfigrator.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import UIKit
import PresenterImpl
import RealmSwift
import RepositoryImpl
import UseCaseImpl

struct GitHubRepositoryListConfigrator {
    
    /// GitHubRepositoryList表示に必要な設定やDIを行う
    ///
    /// - Parameter viewController: GitHubRepositoryListViewController
    func configure(viewController: GitHubRepositoryListViewController) {
        let router = GitHubRepositoryListRouterImpl()
        let realm = try! Realm()
        let repository = GithubRepositoryImpl(realm: realm)
        let useCase = GitHubRepositoryListUseCaseImpl(repository: repository)
        let presenter = GitHubRepositoryListPresenterImpl(router: router, viewController: viewController, useCase: useCase)
        
        router.viewController = viewController
        viewController.presenter = presenter
    }
}
