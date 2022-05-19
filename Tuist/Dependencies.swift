import ProjectDescription
import ProjectDescriptionHelpers

let projectSettings: Settings = .settings(configurations: BuildConfiguration.projectBuildConfigurations)

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .local(path: .relativeToRoot("Projects/SPMModules"))
        ],
        baseSettings: projectSettings,
        targetSettings: [:]
    ),
    platforms: [.iOS]
)
