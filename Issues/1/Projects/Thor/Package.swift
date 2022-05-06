// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: Specs.packageName,
    platforms: Specs.supportedPlatforms,
    products: Specs.products,
    dependencies: Specs.packageDependencies,
    targets: Specs.targets
)

// MARK:- Package Support
struct Specs {}
extension Specs {

    static let packageName: String = "Thor"
    
    static let supportedPlatforms: [SupportedPlatform] = [.iOS(.v13)]
    
    static let products: [Product] = platformTargets.map { $0.libraryProduct() }

    static let targets: [Target] = platformTargets + testTargets

    static let platformTargets: [Target] = Targets
        .allCases
        .map { target in
            target.target(
                dependencies: target.internalDependencies + target.externalDependencies
            )
        }

    static let testTargets: [Target] = platformTargets.map { $0.testTarget() }
    
    static let packageDependencies: [Package.Dependency] = [
        .snapKitLibrary,
        .alamofireLibrary,
        .kingfisherLibrary,
        .webViewLibrary
    ]
}

enum Targets: String, CaseIterable {
    
    case core = "Core"
    case styles = "Styles"
    case components = "Components"
    case networking = "Networking"
    case webKit = "WebBrowserKit"
    case menuWidget = "MenuWidget"
    
    var name: String { rawValue }
    
    var internalDependencies: [Target.Dependency] {
        var deps: [Targets] = []
        switch self {
            case .styles: deps = [.core]
            case .components: deps = [.core, .styles]
            case .networking: deps = [.core]
            case .webKit: deps = [.core]
            case .menuWidget: deps = [.core, .styles, .components]
            default: deps = []
        }
        return deps.map { Target.Dependency.byName(name: $0.name) }
    }
    
    var externalDependencies: [Target.Dependency] {
        switch self {
            case .components: return [
                .product(name: "SnapKit", package: "SnapKit"),
            ]
            case .networking: return [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ]
            case .webKit, .menuWidget: return [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "ProgressWebViewController", package: "ProgressWebViewController")
            ]
            default: return []
        }
    }
}
extension Package.Dependency {
    
    static let alamofireLibrary: Package.Dependency = .package(
        name: "Alamofire",
        url: "https://github.com/Alamofire/Alamofire.git",
        .upToNextMajor(from: "5.6.1")
    )
    
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
    
    static let webViewLibrary: Package.Dependency = .package(
        name: "ProgressWebViewController",
        url: "https://github.com/kf99916/ProgressWebViewController.git",
        .exact("3.0.0")
    )
}

extension Targets {
    func target(dependencies: [Target.Dependency] = []) -> Target {
        .target(name: name,
                dependencies: dependencies,
                resources: [.process("Resources")])
    }
}

extension Target {
    
    func libraryProduct(productType: Product.Library.LibraryType? = nil) -> Product {
        .library(name: name,
                 type: productType,
                 targets: [name])
    }

    func testTarget(dependencies: [String] = []) -> Target {
        
        let deps = [name] + dependencies.map { $0 }
        
        return .testTarget(name: name.appending("Tests"),
                           dependencies: deps.map { Dependency(stringLiteral: $0) },
                           exclude: [],
                           resources: [])
    }
}
