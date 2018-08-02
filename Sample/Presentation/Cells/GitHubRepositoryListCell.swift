//
//  GitHubRepositoryListCell.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import UIKit
import Model

class GitHubRepositoryListCell: UITableViewCell {
    
    lazy var repositoryNameLabel: UILabel = {
        let ret = UILabel()
        return ret
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeStructure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeStructure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// CellのView要素をセット設定する
    private func makeStructure() {
        self.contentView.addSubview(repositoryNameLabel)
        repositoryNameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }

    /// Modelをセットする
    ///
    /// - Parameter model: RepositoryListCellModel
    func setModel(_ model: RepositoryListCellModel) {
        repositoryNameLabel.text = model.name
    }
}
