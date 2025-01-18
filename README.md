# turnstile-kit
Helpful extension for using (Cloudflare Turnstile)[https://www.cloudflare.com/application-services/products/turnstile/]

### Setup

```swift
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
    let result = try await req.siteVerify(response: cfTurnstileResponse)

    guard result.success else {
        throw Abort(.unauthorized)
    }
    ...
}

```
