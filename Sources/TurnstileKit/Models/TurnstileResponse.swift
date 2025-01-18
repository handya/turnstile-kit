//
//  TurnstileResponse.swift
//  turnstile-kit
//
//  Created by Andrew Farquharson on 19/01/2025.
//

import Foundation

public struct TurnstileResponse {
    public let success: Bool
    public let errorCodes: [String]
    public let challengeTs: Date?
    public let hostname: String?
    public let metadata: TurnstileResponseMetadata?
    public let messages: [String]?
}

// MARK: - Computed

public extension TurnstileResponse {
    var isTest: Bool {
        return metadata?.resultWithTestingKey ?? false
    }
}

// MARK: - Decodable

extension TurnstileResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case success
        case errorCodes = "error-codes"
        case challengeTs = "challenge_ts"
        case hostname
        case metadata
        case messages
    }

    // Custom initializer for Decodable
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.success = try container.decode(Bool.self, forKey: .success)
        self.errorCodes = try container.decode([String].self, forKey: .errorCodes)

        // Custom date decoding for challenge_ts
        if let challengeTsString = try container.decodeIfPresent(String.self, forKey: .challengeTs) {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            self.challengeTs = formatter.date(from: challengeTsString)
        } else {
            self.challengeTs = nil
        }

        self.hostname = try container.decodeIfPresent(String.self, forKey: .hostname)
        self.metadata = try container.decodeIfPresent(TurnstileResponseMetadata.self, forKey: .metadata)
        self.messages = try container.decodeIfPresent([String].self, forKey: .messages)
    }
}
