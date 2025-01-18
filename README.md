# TurnstileKit
Helpful extension for using [Cloudflare Turnstile](https://www.cloudflare.com/application-services/products/turnstile/)

### Setup

```swift
// dependencies
.package(url: "https://github.com/handya/turnstile-kit", from: "1.1.0")

// Target dependencies
.product(name: "TurnstileKit", package: "turnstile-kit")

import vapor
import TurnstileKit

public func configure(_ app: Application) throws {
    app.turnstile.configuration = .init(secretKey: {{Your Secret Key}})
}

```

### Usage

```swift

func get(_ req: Request) async throws -> HTTPStatus {
    guard let cfTurnstileResponse = query[String.self, at: "cf-turnstile-response"] else {
        throw Abort(.badRequest)
    }
    let result = try await req.turnstileVerify(response: cfTurnstileResponse)

    guard result.success else {
        throw Abort(.unauthorized)
    }
}

```
