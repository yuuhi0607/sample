//
//  GitHubRepositoryListPresenter.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Foundation
import Model
import RxSwift
import RxCocoa

/// PresenterからViewControllerへの通知
public protocol GitHubRepositoryListPresenterOutput: BasicPresenterOutput {
    //ローディングの開始・終了、Error通知メソッドはBasicPresenterOutputで定義済み。
    //ローディングの開始・終了、Error通知メソッドはBaseViewControllerで実装済み
    
}

public protocol GitHubRepositoryListPresenter {
    var viewController: GitHubRepositoryListPresenterOutput? { get set }
    
    var models: BehaviorRelay<[RepositoryListCellModel]> { get }
    
    /// viewDidLoad
    func viewDidLoad()
    
    /// viewWillAppear
    func viewWillAppear()
}
