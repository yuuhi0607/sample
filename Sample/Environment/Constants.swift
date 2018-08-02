//
//  Constants.swift
//  Environment
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation

public enum Constants {
    /// SSL切り替え
    static private let ApiScheme: String = "https://"

    /// Api Domain
    public static let ApiDomain: String = "api.github.com"
    
    /// Api ベースURL
    public static let ApiBaseUrl: String = Constants.ApiScheme + Constants.ApiDomain
}
