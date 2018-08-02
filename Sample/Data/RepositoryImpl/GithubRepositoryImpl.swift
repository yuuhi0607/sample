//
//  GithubRepositoryImpl.swift
//  RepositoryImpl
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation
import Entity
import RepositoryProtocol
import RxSwift
import RealmSwift
import NetworkApi
import NetworkApiImpl
import Logger

public class GithubRepositoryImpl: GithubRepository {
    
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func existsLocalData() -> Bool {
        return !realm.objects(ListOrganizationRepositoryEntity.self).isEmpty
    }
    
    public func loadFromLocalData() -> Single<[ListOrganizationRepositoryEntity]> {
        //将来の非同期実行を考慮してSingleを生成して実行しています
        let task = Single<[ListOrganizationRepositoryEntity]>.create { [unowned self](single) -> Disposable in
            //データ量が増えてパフォーマンスに影響が出てきた場合はDispatchQueueを使用してバックグランド実行等を行ったほうが良い
            let records = Array(self.realm.objects(ListOrganizationRepositoryEntity.self))
            single(.success(records))
            return Disposables.create()
        }
        return task
    }
    
    public func loadFromNetworkApi() -> Single<[ListOrganizationRepositoryEntity]> {
        let task = Single<[ListOrganizationRepositoryEntity]>.create { [unowned self](single) -> Disposable in
            
            let req = ListOrganizationRepositoriesImpl()
            req.asyncRequest(query: ListOrganizationRepositoriesParam(), completion: { (result) in
                switch result {
                case .success(let entities):
                    // 取得したデータをローカルに保存
                    self.saveToLocal(entities: entities)
                    single(.success(entities))
                case .failure(let error):
                    single(.error(error))
                }
            })
            return Disposables.create()
        }
        return task
    }
    
    /// APIから取得したリポジトリ一覧をRealmに保存する
    ///
    /// - Parameter entities: 保存したいEntity
    private func saveToLocal(entities: [ListOrganizationRepositoryEntity]) {
        do {
            try realm.write {
                //ひとまずUpdate trueとしておく
                //アプリ仕様に応じて変更すること
                realm.add(entities, update: true)
            }
        } catch {
            //キャッシュ保存なのでログを出して終了
            //必要があればrethrow
            Logger.repositoryLogger.error(error)
        }
    }
}
