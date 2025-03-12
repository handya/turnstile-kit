//
//  Request+TurnstileKit.swift
//  turnstile-kit
//
//  Created by Andrew Farquharson on 19/01/2025.
//

import Foundation
import Vapor

public extension Request {
    func turnstileVerify(response: String) async throws -> TurnstileResponse {
        guard let config = self.application.turnstile.configuration else {
            throw TurnstileKitError.notConfigured
        }

        let request: TurnstileRequest = .init(response: response, secret: config.secretKey)

        let response = try await self.client.post(.cloudFlareTurnstileSiteVerifyURL, content: request)

        guard let validationResponse = try? response.content.decode(TurnstileResponse.self) else {
            throw TurnstileKitError.response
        }

        return validationResponse
    }
}

private extension URI {
    static let cloudFlareTurnstileSiteVerifyURL: URI = URI(
        string: "https://challenges.cloudflare.com/turnstile/v0/siteverify"
    )
}
