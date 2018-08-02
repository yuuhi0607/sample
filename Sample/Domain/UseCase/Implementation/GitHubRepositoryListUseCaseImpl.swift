//
//  GitHubRepositoryListUseCaseImpl.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Model
import Entity
import Enum
import Translator
import RepositoryProtocol
import UseCaseProtocol

public struct GitHubRepositoryListUseCaseImpl: GitHubRepositoryListUseCase {
    
    public var models: BehaviorRelay<[RepositoryListCellModel]> = BehaviorRelay(value: [])
    
    private let repository: GithubRepository
    private let translator: RepositoryListCellModelTranslator
    
    public init(repository: GithubRepository) {
        self.repository = repository
        self.translator = RepositoryListCellModelTranslator()
    }

    public func loadRepositoryList() -> Single<Void> {
        //キャッシュ状態に応じて取得元を変更
        if repository.existsLocalData() {
            return repository.loadFromLocalData().map({ (records) -> Void in
                self.translate(records: records)
            })
        } else {
            return repository.loadFromNetworkApi().map({ (records) -> Void in
                self.translate(records: records)
            })
        }
    }
    
    /// EntityからModelに変換
    ///
    /// - Parameter records: ListOrganizationRepositoryEntity配列
    private func translate(records: [ListOrganizationRepositoryEntity]) {
        let tmp = records.map { translator.translate($0) }
        models.accept(tmp)
    }
}
