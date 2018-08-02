//
//  Result.swift
//  Entity
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation

public enum Result<T, E> {
    case success(T)
    case failure(E)
}

public enum SelectResult<T> {
    case success(T)
    case cancel
}
