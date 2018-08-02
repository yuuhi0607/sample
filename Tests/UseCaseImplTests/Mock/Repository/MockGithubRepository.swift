//
//  MockGithubRepository.swift
//  UseCaseImplTests
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation
import RepositoryProtocol
import RxSwift
import Entity

/// テスト用GithubRepositoryモックスラス
class MockGithubRepository: GithubRepository {
    
    var existsLocalDataCalled = false
    var existsLocalDataResult = true
    func existsLocalData() -> Bool {
        existsLocalDataCalled = true
        return existsLocalDataResult
    }
    
    var loadFromLocalDataCalled = false
    var loadFromLocalDataResult = Single<[ListOrganizationRepositoryEntity]>.just([])
    func loadFromLocalData() -> PrimitiveSequence<SingleTrait, [ListOrganizationRepositoryEntity]> {
        loadFromLocalDataCalled = true
        return loadFromLocalDataResult
    }
    
    var loadFromNetworkApiCalled = false
    var loadFromNetworkApiResult = Single<[ListOrganizationRepositoryEntity]>.just([])
    func loadFromNetworkApi() -> PrimitiveSequence<SingleTrait, [ListOrganizationRepositoryEntity]> {
        loadFromNetworkApiCalled = true
        return loadFromNetworkApiResult
    }
    
    
}
