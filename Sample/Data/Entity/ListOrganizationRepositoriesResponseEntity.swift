//
//  ListOrganizationRepositoryEntity.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/// レスポンスエンティティーとRealmのObjectを共通化
public class ListOrganizationRepositoryEntity: Object, Decodable {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var nodeId: String = ""
    @objc dynamic public var name: String = ""
    @objc dynamic public var fullName: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
