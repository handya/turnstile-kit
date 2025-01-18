//
//  Application+TurnstileKit.swift
//  turnstile-kit
//
//  Created by Andrew Farquharson on 19/01/2025.
//

import Foundation
import Vapor

public extension Application {
    var turnstile: Turnstile {
        .init(application: self)
    }

    struct Turnstile {
        struct ConfigurationKey: StorageKey {
            typealias Value = TurnstileConfiguration
        }

        public var configuration: TurnstileConfiguration? {
            get {
                self.application.storage[ConfigurationKey.self]
            }
            nonmutating set {
                self.application.storage[ConfigurationKey.self] = newValue
            }
        }

        let application: Application
    }
}
