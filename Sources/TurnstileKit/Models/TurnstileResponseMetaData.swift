//
//  TurnstileResponseMetaData.swift
//  turnstile-kit
//
//  Created by Andrew Farquharson on 19/01/2025.
//

import Foundation

public struct TurnstileResponseMetadata {
    public  let resultWithTestingKey: Bool?
    public let ephemeralID: String?
}

// MARK: - Decodable

extension TurnstileResponseMetadata: Decodable {
    enum CodingKeys: String, CodingKey {
        case resultWithTestingKey = "cf-turnstile-result_with_testing_key"
        case ephemeralID = "cf-turnstile-ephemeral_id"
    }
}
