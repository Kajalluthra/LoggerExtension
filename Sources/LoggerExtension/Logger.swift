import Foundation
import os

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.silverrailtech.railui"

    // Here we'll have different categories to differentiate the origin of the log messages
    // Usage: Logger.<categoryName>.log(level:<logLevel>, message: String) --> Ex: Logger.ui.log(level: .info, message "The log message")

    public static var crashReporter: CrashReporter?
    
    // Logs related with configuration files
    public static let configuration = Logger(subsystem: subsystem, category: "configuration")

    // Logs related with views and ui
    public static let ui = Logger(subsystem: subsystem, category: "ui") // swiftlint:disable:this identifier_name

    //  Logs related with services
    public static let service = Logger(subsystem: subsystem, category: "service")

    //  Logs related with endpoints
    public static let endpoint = Logger(subsystem: subsystem, category: "endpoint")

    //  Logs related with networking
    public static let network = Logger(subsystem: subsystem, category: "network")

    //  Logs in tests
    public static let test = Logger(subsystem: subsystem, category: "test")

    // Function to include automatically file, function and line in each log call
    public func log(level: OSLogType, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let logMessage = "\(file) - \(function) (line \(line)): \(message)"
        self.log(level: level, "\(logMessage)")
        if let crashReporter = Logger.crashReporter {
            crashReporter.log(message: logMessage)
        }
    }

}
