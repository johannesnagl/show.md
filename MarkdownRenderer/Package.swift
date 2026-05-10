// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MarkdownRenderer",
    platforms: [.macOS("26.0")],
    products: [
        .library(name: "MarkdownRenderer", targets: ["MarkdownRenderer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-markdown.git", from: "0.8.0"),
        .package(url: "https://github.com/apple/swift-testing.git", from: "0.99.0"),
    ],
    targets: [
        .target(
            name: "MarkdownRenderer",
            dependencies: [
                .product(name: "Markdown", package: "swift-markdown"),
            ],
            resources: [
                .copy("Resources"),
            ]
        ),
        .testTarget(
            name: "MarkdownRendererTests",
            dependencies: [
                "MarkdownRenderer",
                .product(name: "Testing", package: "swift-testing"),
            ]
        ),
    ]
)
