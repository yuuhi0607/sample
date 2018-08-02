//
//  GitHubRepositoryListViewController.swift
//  Sample
//
//  Created by Hirano on 2018/08/02.
//  Copyright (c) 2018年 hirano. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift
import PresenterProtocol
import SnapKit

public class GitHubRepositoryListViewController: UIViewController {
    
    var presenter: GitHubRepositoryListPresenter?
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let ret = UITableView()
        if #available(iOS 11.0, *) {
            ret.contentInsetAdjustmentBehavior = .automatic
        }
        ret.register(GitHubRepositoryListCell.self, forCellReuseIdentifier: "GitHubRepositoryListCell")
        return ret
    }()
    
    // MARK: View lifecycle
    
    override public  func viewDidLoad() {
        super.viewDidLoad()
        makeStructure()
        bind()
        presenter?.viewDidLoad()
    }
    
    override public  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    /// 画面を作る
    private func makeStructure() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    /// データバインディングを行う
    private func bind() {
        presenter?.models.bind(to: self.tableView.rx.items) { (table, index, model) in
            guard let cell = table.dequeueReusableCell(withIdentifier: "GitHubRepositoryListCell", for: IndexPath(row: index, section: 0)) as? GitHubRepositoryListCell else {
                fatalError("error instantiate")
            }
            cell.selectionStyle = .none
            cell.setModel(model)
            return cell
        }.disposed(by: disposeBag)
    }
}

extension GitHubRepositoryListViewController: GitHubRepositoryListPresenterOutput {
    public func showLoading() {
        SVProgressHUD.show()
    }
    
    public func dismissLoading() {
        SVProgressHUD.dismiss()
    }
    
    public func notifyError(error: Error) {
        //エラータイプに応じてメッセージを変える
        //サンプルのため固定文言を表示しています
        let alert = UIAlertController(title: "エラー", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
