//
//  ListOrganizationRepositories.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import UIKit
import Entity

/// リクエストパラメータ(APIに認証や必要なパラメータを与える場合に使用)
public struct ListOrganizationRepositoriesParam: Codable {
    
//    let authToken: String
//    
//    public init(authToken: String) {
//        self.authToken = authToken
//    }
//    
//    private enum CodingKeys: String, CodingKey {
//        case authToken = "auth_token"
//    }
    
    public init() { /*仮実装*/ }
}

public protocol ListOrganizationRepositories: ApiRequestProtocol where RequestParamTypes == ListOrganizationRepositoriesParam, ResponseTypes == [ListOrganizationRepositoryEntity] {
}
