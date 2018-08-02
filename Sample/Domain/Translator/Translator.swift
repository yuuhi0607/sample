//
//  TranslatorProtocol.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation

public protocol Translator {
    associatedtype Input
    associatedtype Output
    
    func translate(_ input: Input) -> Output
}
