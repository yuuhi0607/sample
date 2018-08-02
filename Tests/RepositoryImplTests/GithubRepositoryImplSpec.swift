//
//  GithubRepositoryImplSpec.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RealmSwift
import Entity
import OHHTTPStubs

@testable import RepositoryImpl

class GithubRepositoryImplSpec: QuickSpec {
    
    override func spec() {
        var target: GithubRepositoryImpl!
        var realm: Realm!
        var disposeBag: DisposeBag!
        describe("リポジトリ一覧リポジトリ") {
            beforeEach {
                //テスト用にIn-MemoryRealmインスタンスを生成
                realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))
                target = GithubRepositoryImpl(realm: realm)
                
                disposeBag = DisposeBag()
                
                //OHHTTPStubsにAPIリクエストのスタブをセットする
                stub(condition: isHost("api.github.com")) { (_) -> OHHTTPStubsResponse in
                    //ダミーデータ(JSON)をファイルからロードしてレスポンスとして返す
                    let url = Bundle(for: GithubRepositoryImplSpec.self).url(forResource: "OrgReposTestData", withExtension: nil)
                    let data = try! Data(contentsOf: url!)
                    return OHHTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                }
            }
            afterSuite {
                OHHTTPStubs.removeAllStubs()
            }
            
            context("existsLocalData", {
                it("ローカルキャッシュあり", closure: {
                    let dummyData = ListOrganizationRepositoryEntity()
                    dummyData.id = 1
                    dummyData.name = "name"
                    try! realm.write {
                        realm.add(dummyData)
                    }
                    expect(target.existsLocalData()) == true
                })
                
                it("ローカルキャッシュなし", closure: {
                    try! realm.write {
                        realm.deleteAll()
                    }
                    expect(target.existsLocalData()) == false
                })
            })
            
            context("loadFromLocalData", {
                it("empty", closure: {
                    try! realm.write {
                        realm.deleteAll()
                    }
                    target.loadFromLocalData().subscribe(onSuccess: { (result) in
                        expect(result).to(haveCount(0))
                    }, onError: { (error) in
                        XCTFail()
                    }).disposed(by: disposeBag)
                })
                
                it("exists", closure: {
                    let dummyData1 = ListOrganizationRepositoryEntity()
                    dummyData1.id = 1
                    dummyData1.name = "name1"
                    
                    let dummyData2 = ListOrganizationRepositoryEntity()
                    dummyData2.id = 2
                    dummyData2.name = "name2"
                    //テストデータをRealmに追加
                    try! realm.write {
                        realm.add(dummyData1)
                        realm.add(dummyData2)
                    }
                    
                    target.loadFromLocalData().subscribe(onSuccess: { (result) in
                        expect(result).to(haveCount(2))
                        
                        expect(result.first?.name).to(equal("name1"))
                        expect(result.last?.name).to(equal("name2"))
                    }, onError: { (error) in
                        XCTFail()
                    }).disposed(by: disposeBag)
                })
            })
            
            it("test", closure: {
                waitUntil(action: { (done) in
                    target.loadFromNetworkApi().subscribe(onSuccess: { (ret) in
                        expect(ret).to(haveCount(1))
                        expect(ret.first?.name).to(equal("Hello-World"))
                        done()
                    }).disposed(by: disposeBag)
                })
            })
        }
    }
    
}

