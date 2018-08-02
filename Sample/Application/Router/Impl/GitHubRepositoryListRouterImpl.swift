//
//  GitHubRepositoryListRouterImpl.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import UIKit
import RouterProtocol

/// GitHubRepositoryListの画面遷移をまとめる
public class GitHubRepositoryListRouterImpl: GitHubRepositoryListRouter {
    weak public var viewController: UIViewController?
    
    public func unwind() {
        //画面を閉じる処理・戻る処理を実装
        //サンプル未実装
        fatalError("not implemented")
//        viewController?.dismiss(animated: true, completion: nil)
//        or
//        viewController?.navigationController?.popViewController(animated: true)
//        などを行う
    }

    public func showDetail(repoId: Int64) {
        //サンプル未実装
        fatalError("not implemented")
        // 詳細画面を生成して遷移
//        let next = GitHubRepositoryDetailBuilder().build()
//        viewController?.show(next, sender: nil)
//        viewController?.present(next, animated: true, completion: nil)
    }
}
