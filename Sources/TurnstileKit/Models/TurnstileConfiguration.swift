//
//  TurnstileConfiguration.swift
//  turnstile-kit
//
//  Created by Andrew Farquharson on 19/01/2025.
//

import Foundation

public struct TurnstileConfiguration {
    public let secretKey: String

    public init(secretKey: String) {
        self.secretKey = secretKey
    }
}
