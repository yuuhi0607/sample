//
//  GitHubRepositoryListUseCaseImplSpec.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RepositoryProtocol

@testable import UseCaseImpl

class GitHubRepositoryListUseCaseImplSpec: QuickSpec {
    
    override func spec() {
        var disposeBag: DisposeBag!
        var target: GitHubRepositoryListUseCaseImpl!
        var repository: MockGithubRepository!
        describe("リポジトリ一覧ユースケース") {
            beforeEach {
                disposeBag = DisposeBag()
                repository = MockGithubRepository()
                target = GitHubRepositoryListUseCaseImpl(repository: repository)
            }
            
            context("loadRepositoryList", {
                
                it("ローカルデータあり", closure: {
                    repository.existsLocalDataResult = true
                    expect(repository.existsLocalDataCalled) == false
                    expect(repository.loadFromNetworkApiCalled) == false
                    expect(repository.loadFromLocalDataCalled) == false
                    
                    target.loadRepositoryList().subscribe(onSuccess: nil, onError: { (error) in
                        XCTFail()
                    }).disposed(by: disposeBag)
                    //ローカルデータを取得したこと
                    expect(repository.loadFromNetworkApiCalled) == false
                    expect(repository.loadFromLocalDataCalled) == true
                })
                
                it("ローカルデータなし", closure: {
                    repository.existsLocalDataResult = false
                    expect(repository.existsLocalDataCalled) == false
                    expect(repository.loadFromNetworkApiCalled) == false
                    expect(repository.loadFromLocalDataCalled) == false
                    
                    target.loadRepositoryList().subscribe(onSuccess: nil, onError: { (error) in
                        XCTFail()
                    }).disposed(by: disposeBag)
                    //ローカルデータを取得したこと
                    expect(repository.loadFromNetworkApiCalled) == true
                    expect(repository.loadFromLocalDataCalled) == false
                })
            })
            
        }
    }
    
}

