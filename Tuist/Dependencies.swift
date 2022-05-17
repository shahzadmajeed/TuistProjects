import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .local(path: .relativeToRoot("Projects/SPMModules"))
        ],
        //productTypes: ["WebBrowserKit": .framework],
        baseSettings: .settings(),
        targetSettings: [:]
    ),
    platforms: [.iOS]
)
