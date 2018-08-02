//
//  RepositoryListCellModelTranslatorSpec.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import Quick
import Nimble
import Entity

@testable import Translator

class RepositoryListCellModelTranslatorSpec: QuickSpec {
    
    override func spec() {
        var target: RepositoryListCellModelTranslator!
        
        describe("変換テスト") {
            beforeEach {
                target = RepositoryListCellModelTranslator()
            }
            
            it("nameがmodel.nameにセットされること", closure: {
                let input = ListOrganizationRepositoryEntity()
                input.name = "name1"
                input.fullName = "fullname1"
                let result = target.translate(input)
                expect(result.name).to(equal("name1"))
            })
        }
    }
    
}

