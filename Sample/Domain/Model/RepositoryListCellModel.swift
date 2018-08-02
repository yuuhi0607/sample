//
//  RepositoryListCellModel.swift
//  Model
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation


/// リポジトリ一覧のTableViewCellで使用するModel
public struct RepositoryListCellModel {
    /// リポジトリ名
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
