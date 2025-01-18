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

        let url = URI(string: "https://challenges.cloudflare.com/turnstile/v0/siteverify")

        // Make the POST request
        let response = try await self.client.post(url, content: request)

        // Decode the response from the third-party API
        guard let validationResponse = try? response.content.decode(TurnstileResponse.self) else {
            throw Abort(.badRequest, reason: "Invalid response from the third-party API")
        }

        // Return the validation result
        return validationResponse
    }
}
