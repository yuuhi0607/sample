//
//  GitHubRepositoryListBuilder.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import UIKit

/// リポジトリ一覧画面を作成する
struct GitHubRepositoryListBuilder {
    func build() -> UIViewController {
        let viewController = GitHubRepositoryListViewController(nibName: nil, bundle: nil)
        GitHubRepositoryListConfigrator().configure(viewController: viewController)
        return viewController
    }
}
