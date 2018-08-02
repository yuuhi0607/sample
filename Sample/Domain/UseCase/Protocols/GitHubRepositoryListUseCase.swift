//
//  GitHubRepositoryListUseCase.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Model

public protocol GitHubRepositoryListUseCase {
    /// リポジトリ一覧
    var models: BehaviorRelay<[RepositoryListCellModel]> { get }
    
    /// リポジトリ一覧を取得する
    func loadRepositoryList() -> Single<Void>
}
