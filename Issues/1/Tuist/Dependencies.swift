import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .local(path: .relativeToRoot("Projects/Thor")),
            .remote(url: "https://github.com/Alamofire/Alamofire",
                    requirement: .upToNextMajor(from: "5.0.0"))
        ],
        //productTypes: ["WebBrowserKit": .framework],
        baseSettings: .settings(),
        targetSettings: [:]
    ),
    platforms: [.iOS]
)
