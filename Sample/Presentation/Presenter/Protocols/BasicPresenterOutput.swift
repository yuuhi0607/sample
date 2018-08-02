//
//  BasicPresenterOutput.swift
//  PresenterProtocol
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation

/// 基本的なVC通知
public protocol BasicPresenterOutput: class {
    /// ローディングインディケーターを表示
    ///
    func showLoading()
    
    /// ローディングインディケーターを閉じる
    ///
    func dismissLoading()
    
    /// VCヘエラー通知を行う
    ///
    /// - Parameter error: 通知するError
    func notifyError(error: Error)
}
