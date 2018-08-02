//
//  ListOrganizationRepositoriesImpl.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Foundation
import Environment
import Entity
import NetworkApi

public struct ListOrganizationRepositoriesImpl: ListOrganizationRepositories {
    
    public typealias RequestParamTypes = ListOrganizationRepositoriesParam
    public typealias ResponseTypes = [ListOrganizationRepositoryEntity]
    
    public let url: String
    
    public init() {
        //サンプルのためOrganizationは固定
        url = Constants.ApiBaseUrl + "/orgs/mixi-inc/repos"
    }
    
//    /// 取得するOrganizationを変更する場合
//    ///
//    /// - Parameter organization: Organization
//    public init(organization: String) {
//        url = Constants.ApiBaseUrl + "/orgs/\(organization)/repos"
//    }
}
