//
//  OSLog+Logger.swift
//  New Apps Test
//
//  Created by Pierre Simon on 20/11/2024.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let appLog = Logger(subsystem: subsystem, category: "appLog")
}
