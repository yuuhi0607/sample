//
//  GithubRepository.swift
//  RepositoryProtocol
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation
import Entity
import RxSwift

public protocol GithubRepository {
    
    
    /// ローカルに取得済みが存在するか
    ///
    /// - Returns: true: ある, false: ない
    func existsLocalData() -> Bool
    
    /// ローカルに取得済みのリポジトリ一覧を取得する
    ///
    /// - Returns: Single<[ListOrganizationRepositoryEntity]>
    func loadFromLocalData() -> Single<[ListOrganizationRepositoryEntity]>
    
    /// ネットワークからリポジトリ一覧を取得する
    ///
    /// - Returns: Single<[ListOrganizationRepositoryEntity]>
    func loadFromNetworkApi() -> Single<[ListOrganizationRepositoryEntity]>
}
