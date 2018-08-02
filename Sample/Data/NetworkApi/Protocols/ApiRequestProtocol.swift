//
//  ApiRequestProtocol.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Foundation
import Enum

public typealias ApiResult<Value> = Result<Value, Error>

/// Apiリクエスト送信処理を共通化するためのProtocol
public protocol ApiRequestProtocol {
    
    /// リクエストパラメータ
    associatedtype RequestParamTypes: Encodable
    
    /// APIの結果
    associatedtype ResponseTypes: Decodable
    
    /// APIのURL
    var url: String { get }
}
