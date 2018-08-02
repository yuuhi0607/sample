//
//  ApiRequestImpl.swift
//  NetworkApiImpl
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation
import NetworkApi
import Enum
import Entity
import Logger

// MARK: - API送信処理をgenericとextensionで共通処理化
public extension ApiRequestProtocol {
    /// 非同期リクエストを送信する
    ///
    /// - Parameters:
    ///   - query: リクエストパラメータ
    ///   - completion: 非同期コールバック(メインスレッドでコールされます)
    func asyncRequest(query: RequestParamTypes, completion: @escaping (ApiResult<ResponseTypes>) -> Void) {
        
        var req: URLRequest = URLRequest(url: URL(string: url)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10.0)
        req.httpMethod = "GET"
        
        //リクエストヘッダセット
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("application/vnd.github.inertia-preview+json", forHTTPHeaderField: "Accept")

        //POSTの場合に使用 サンプルではGETしか使わない
//        do {
//            req.httpBody = try JSONEncoder().encode(query)
//        } catch let error {
//            Logger.apiLogger.error(error)
//            DispatchQueue.main.async {
//                completion(.failure(error))
//            }
//            return
//        }
        if Logger.apiLogger.outputLevel == .verbose, let body: Data = req.httpBody, let txtBody = String(data: body, encoding: .utf8) {
            let log: String = req.description.appending(": ").appending(txtBody)
            Logger.apiLogger.verbose(log)
        } else {
            Logger.apiLogger.debug(self.url)
        }
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: req) { (data, response, error) in
            let result: ApiResult<ResponseTypes>
            if Logger.apiLogger.outputLevel == .verbose, let data = data {
                Logger.apiLogger.verbose(String(data: data, encoding: .utf8))
            }
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            guard error == nil else {
                result = .failure(error!)
                return
            }
            guard let data = data else {
                //TODO: 実際のアプリ開発ではエラー定義を行って返す。
                result = .failure(NSError(domain: "NetworkApiImpl", code: -1, userInfo: [:]))
                return
            }
            do {
                assert(!Thread.isMainThread)
                let ret: ResponseTypes = try JSONDecoder().decode(ResponseTypes.self, from: data)
                result = .success(ret)
            } catch let error {
                Logger.apiLogger.error(self.url)
                Logger.apiLogger.error(error)
                if Logger.apiLogger.outputLevel != .verbose {
                    Logger.apiLogger.error(String(data: data, encoding: .utf8))
                }
                result = .failure(error)
            }
        }
        task.resume()
    }
}
