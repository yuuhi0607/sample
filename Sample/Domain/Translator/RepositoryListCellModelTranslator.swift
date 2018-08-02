//
//  RepositoryListCellModelTranslator.swift
//  Translator
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation
import Entity
import Model

public struct RepositoryListCellModelTranslator: Translator {
    public typealias Input = ListOrganizationRepositoryEntity
    public typealias Output = RepositoryListCellModel
    
    public init() {
        
    }
    
    /// ListOrganizationRepositoryEntityからRepositoryListCellModelへの変換を行う
    public func translate(_ input: ListOrganizationRepositoryEntity) -> RepositoryListCellModel {
        return RepositoryListCellModel(name: input.name)
    }
    
}
