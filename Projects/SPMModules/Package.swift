// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SPMModules",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [.library(name: "Feature1", targets: ["Feature1"])],
    dependencies: [.snapKitLibrary, .kingfisherLibrary],
    targets: [
        .target(name: "Feature1",
                dependencies: [
                    .product(name: "SnapKit", package: "SnapKit"),
                    .product(name: "Kingfisher", package: "Kingfisher")],
                resources: [.process("Resources/Fonts")]
               ),
        .testTarget(name: "Feature1Tests", dependencies: ["Feature1"])
    ]
)

extension Package.Dependency {
    static let snapKitLibrary: Package.Dependency = .package(
        name: "SnapKit",
        url: "https://github.com/SnapKit/SnapKit.git",
        .upToNextMajor(from: "5.0.1")
    )
    
    static let kingfisherLibrary: Package.Dependency = .package(
        name: "Kingfisher",
        url: "https://github.com/onevcat/Kingfisher.git",
        .exact("7.1.1")
    )
}
