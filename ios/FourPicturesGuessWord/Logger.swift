//
//  Logger.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-22.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

class Logger {
    
    static var defaultLogger = Logger()
    
    func log(_ message: String) {
        print(message)
    }
    
}

func tryAndLog<T>(_ executable: @autoclosure () throws -> T, withDefault defaultValue: T, logger: Logger = Logger.defaultLogger, file: String = #file, line: Int = #line) -> T {
    do {
        return try executable()
    }
    catch let error {
        logger.log("Logged excpetion: \(error.localizedDescription), in \(file), at \(line)")
    }
    
    return defaultValue
}

func tryAndLog(_ executable: @autoclosure () throws -> Void, logger: Logger = Logger.defaultLogger, file: String = #file, line: Int = #line) {
    tryAndLog(executable, withDefault: (), logger: logger, file: file, line: line)
}
