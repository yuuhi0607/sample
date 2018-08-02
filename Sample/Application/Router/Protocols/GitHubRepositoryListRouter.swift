//
//  GitHubRepositoryListRouter.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Foundation

public protocol GitHubRepositoryListRouter: class {
    
    /// 前の画面に戻る
    func unwind()
    
    /// 詳細画面を表示する(サンプルのため未実装)
    ///
    /// - Parameter repoId: リポジトリID
    func showDetail(repoId: Int64)
}
