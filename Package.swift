// swift-tools-version:5.7
import PackageDescription
import Foundation

let package = Package(
    name: "turnstile-kit",
    platforms: [
       .macOS(.v10_15),
    ],
    products: [
        .library(name: "TurnstileKit", targets: ["TurnstileKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0")
    ],
    targets: [
        .target(name: "TurnstileKit", dependencies: [
            .product(name: "Vapor", package: "vapor")
        ]),
        .testTarget(name: "TurnstileKitTests", dependencies: [
            .target(name: "TurnstileKit"),
            .product(name: "XCTVapor", package: "vapor")
        ]),
    ]
)
