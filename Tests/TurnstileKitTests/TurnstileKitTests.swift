import XCTest
import Vapor
@testable import TurnstileKit

final class TurnstileTests: XCTestCase {

    func testTurnstileRequestEncoding() throws {
        let request = TurnstileRequest(response: "test-response", secret: "test-secret")
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(request)

        let jsonString = String(data: jsonData, encoding: .utf8)
        XCTAssertNotNil(jsonString)
        XCTAssertTrue(jsonString?.contains("\"response\":\"test-response\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"secret\":\"test-secret\"") ?? false)
    }

    func testTurnstileResponseDecodingValid() throws {
        let validJSON = """
        {
            "success": true,
            "error-codes": [],
            "challenge_ts": "2025-01-19T12:34:56.789Z",
            "hostname": "example.com",
            "metadata": {
                "cf-turnstile-result_with_testing_key": true,
                "cf-turnstile-ephemeral_id": "ephemeral-id-123"
            },
            "messages": ["All good"]
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let response = try decoder.decode(TurnstileResponse.self, from: validJSON)

        XCTAssertTrue(response.success)
        XCTAssertEqual(response.errorCodes.count, 0)
        XCTAssertNotNil(response.challengeTs)
        XCTAssertEqual(response.hostname, "example.com")
        XCTAssertEqual(response.metadata?.resultWithTestingKey, true)
        XCTAssertEqual(response.metadata?.ephemeralID, "ephemeral-id-123")
        XCTAssertEqual(response.messages?.first, "All good")
    }
}
