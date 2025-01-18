//
//  TurnstileRequest.swift
//  turnstile-kit
//
//  Created by Andrew Farquharson on 19/01/2025.
//

import Foundation
import Vapor

public struct TurnstileRequest {
    public let response: String
    public let secret: String

    public init(response: String, secret: String) {
        self.response = response
        self.secret = secret
    }
}

// MARK: - Content

extension TurnstileRequest: Content { }
