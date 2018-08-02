//
//  Logger.swift
//  Logger
//
//  Created by Hirano on 2018/08/02.
//  Copyright © 2018年 hirano. All rights reserved.
//

import Foundation
import XCGLogger

public enum LoggerLogLevel: Int {
    case verbose
    case debug
    case info
    case warning
    case error
    case severe
    case none
}

/** ロガー
  - 外部ライブラリをラップしています。
 */
public struct Logger {
    let logger: XCGLogger
    init(logger: XCGLogger) {
        self.logger = logger
        switch logger.outputLevel {
        case .verbose:
            outputLevel = .verbose
        case .debug:
            outputLevel = .debug
        case .info:
            outputLevel = .info
        case .warning:
            outputLevel = .warning
        case .error:
            outputLevel = .error
        case .severe:
            outputLevel = .severe
        case .none:
            outputLevel = .none
        }
    }
    
    /// LogOutputLebelを変更する
    public var outputLevel: LoggerLogLevel {
        didSet {
            switch outputLevel {
            case .verbose:
                logger.outputLevel = .verbose
            case .debug:
                logger.outputLevel = .debug
            case .info:
                logger.outputLevel = .info
            case .warning:
                logger.outputLevel = .warning
            case .error:
                logger.outputLevel = .error
            case .severe:
                logger.outputLevel = .severe
            case .none:
                logger.outputLevel = .none
            }
        }
    }
    
    /// Log something at the Verbose log level.
    ///
    /// - Parameters:
    ///     - closure:      A closure that returns the object to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///     - userInfo:     Dictionary for adding arbitrary data to the log message, can be used by filters/formatters etc
    ///
    /// - Returns:  Nothing.
    ///
    public func verbose(_ closure: @autoclosure () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
        logger.verbose(closure, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo)
    }
    
    /// Log something at the Debug log level.
    ///
    /// - Parameters:
    ///     - closure:      A closure that returns the object to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///     - userInfo:     Dictionary for adding arbitrary data to the log message, can be used by filters/formatters etc
    ///
    /// - Returns:  Nothing.
    ///
    public func debug(_ closure: @autoclosure () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
        logger.debug(closure, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo)
    }
    
    /// Log something at the Info log level.
    ///
    /// - Parameters:
    ///     - closure:      A closure that returns the object to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///     - userInfo:     Dictionary for adding arbitrary data to the log message, can be used by filters/formatters etc
    ///
    /// - Returns:  Nothing.
    ///
    public func info(_ closure: @autoclosure () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
        logger.info(closure, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo)
    }
    
    /// Log something at the Warning log level.
    ///
    /// - Parameters:
    ///     - closure:      A closure that returns the object to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///     - userInfo:     Dictionary for adding arbitrary data to the log message, can be used by filters/formatters etc
    ///
    /// - Returns:  Nothing.
    ///
    public func warning(_ closure: @autoclosure () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
        logger.warning(closure, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo)
    }
    
    /// Log something at the Error log level.
    ///
    /// - Parameters:
    ///     - closure:      A closure that returns the object to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///     - userInfo:     Dictionary for adding arbitrary data to the log message, can be used by filters/formatters etc
    ///
    /// - Returns:  Nothing.
    ///
    public func error(_ closure: @autoclosure () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
        logger.error(closure, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo)
    }
    
    /// Log something at the Severe log level.
    ///
    /// - Parameters:
    ///     - closure:      A closure that returns the object to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///     - userInfo:     Dictionary for adding arbitrary data to the log message, can be used by filters/formatters etc
    ///
    /// - Returns:  Nothing.
    ///
    public func severe(_ closure: @autoclosure () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
        logger.severe(closure, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo)
    }
}

public extension Logger {
    public static var applicationLogger: Logger = Logger(logger: XCGLogger(identifier: "ApplicationLog", includeDefaultDestinations: true))
    public static var repositoryLogger: Logger = Logger(logger: XCGLogger(identifier: "RepositoryLog", includeDefaultDestinations: true))
    public static var apiLogger: Logger = Logger(logger: XCGLogger(identifier: "APILog", includeDefaultDestinations: true))
    public static var uiLogger: Logger = Logger(logger: XCGLogger(identifier: "UILog", includeDefaultDestinations: true))
    public static var presenterLogger: Logger = Logger(logger: XCGLogger(identifier: "PresenterLog", includeDefaultDestinations: true))
    public static var useCaseLogger: Logger = Logger(logger: XCGLogger(identifier: "UseCaseLog", includeDefaultDestinations: true))
    public static var dataLogger: Logger = Logger(logger: XCGLogger(identifier: "Dataog", includeDefaultDestinations: true))
}
