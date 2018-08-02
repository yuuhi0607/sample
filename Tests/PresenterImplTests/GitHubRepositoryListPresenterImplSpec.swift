//
//  GitHubRepositoryListPresenterImplSpec.swift
//  Sample
//
//  Created by Hirano on 2018/08/03.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Quick
import Nimble
import Model
import RxSwift
import RxCocoa
import RxTest
import RouterProtocol
import PresenterProtocol
import UseCaseProtocol

@testable import PresenterImpl

class GitHubRepositoryListPresenterImplSpec: QuickSpec {
    
    override func spec() {
        var disposeBag: DisposeBag!
        var target: GitHubRepositoryListPresenterImpl!
        var router: MockGitHubRepositoryListRouter!
        var output: MockGitHubRepositoryListPresenterOutput!
        var usecase: MockGitHubRepositoryListUseCase!
        
        describe("リポジトリ一覧Presenter") {
            beforeEach {
                disposeBag = DisposeBag()
                router = MockGitHubRepositoryListRouter()
                output = MockGitHubRepositoryListPresenterOutput()
                usecase = MockGitHubRepositoryListUseCase()
                target = GitHubRepositoryListPresenterImpl(router: router, viewController: output, useCase: usecase)
            }
            
            it("model bind", closure: {
                //UseCaseのModelをスルーしていること
                let scheduler = TestScheduler(initialClock: 0)
                let result = scheduler.createObserver([RepositoryListCellModel].self)
                let data = scheduler.createColdObservable([
                    next(10, [RepositoryListCellModel(name: "name1")]),
                    next(20, [RepositoryListCellModel(name: "name1"), RepositoryListCellModel(name: "name2")])
                ])
                expect(target.models.value).to(haveCount(0))
                target.models.asObservable().bind(to: result).disposed(by: disposeBag)
                data.bind(to: usecase.models).disposed(by: disposeBag)
                
                scheduler.start()
                
                expect(result.events).to(haveCount(3))
                expect(result.events[0].value.element).to(haveCount(0))
                expect(result.events[1].value.element).to(haveCount(1))
                expect(result.events[2].value.element).to(haveCount(2))
                expect(result.events[1].value.element?.first?.name).to(equal("name1"))
                expect(result.events[2].value.element?.first?.name).to(equal("name1"))
                expect(result.events[2].value.element?.last?.name).to(equal("name2"))
            })
            
            context("viewDidLoad", {
                it("success", closure: {
                    usecase.loadRepositoryListResult = Single<Void>.just(())
                    
                    expect(output.showLoadingCalled) == false
                    expect(output.dismissLoadingCalled) == false
                    expect(output.notifyErrorError).to(beNil())
                    
                    target.viewDidLoad()
                    //ローディング表示・非表示がVCで実行されたこと
                    expect(output.showLoadingCalled) == true
                    expect(output.dismissLoadingCalled) == true
                    //エラーがVCへ通知されていないこと
                    expect(output.notifyErrorError).to(beNil())
                })
                
                it("error", closure: {
                    usecase.loadRepositoryListResult = Single.error(NSError(domain: "TestError", code: -1, userInfo: nil))
                    
                    expect(output.showLoadingCalled) == false
                    expect(output.dismissLoadingCalled) == false
                    expect(output.notifyErrorError).to(beNil())
                    
                    target.viewDidLoad()
                    //ローディング表示・非表示がVCで実行されたこと
                    expect(output.showLoadingCalled) == true
                    expect(output.dismissLoadingCalled) == true
                    
                    //エラーがVCへ通知されたこと
                    expect(output.notifyErrorError).toNot(beNil())
                })
            
            })
        }
    }
}

class MockGitHubRepositoryListRouter: GitHubRepositoryListRouter {
    var unwindCalled = false
    func unwind() {
        unwindCalled = true
    }
    
    var showDetailRepoId: Int64?
    func showDetail(repoId: Int64) {
        showDetailRepoId = repoId
    }
}

class MockGitHubRepositoryListPresenterOutput: GitHubRepositoryListPresenterOutput {
    var showLoadingCalled = false
    func showLoading() {
        showLoadingCalled = true
    }
    
    var dismissLoadingCalled = false
    func dismissLoading() {
        dismissLoadingCalled = true
    }
    
    var notifyErrorError: Error?
    func notifyError(error: Error) {
        notifyErrorError = error
    }
    
    
}

class MockGitHubRepositoryListUseCase: GitHubRepositoryListUseCase {
    var models: BehaviorRelay<[RepositoryListCellModel]> = BehaviorRelay(value: [])
    
    var loadRepositoryListResult = Single<Void>.just(())
    func loadRepositoryList() -> PrimitiveSequence<SingleTrait, Void> {
        return loadRepositoryListResult
    }
}
