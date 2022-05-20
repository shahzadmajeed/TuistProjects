import ProjectDescription
import ProjectDescriptionHelpers

//let projectSettings: Settings = .settings(configurations: BuildConfiguration.projectBuildConfigurations)

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .local(path: .relativeToRoot("Projects/SPMModules"))
        ],
        baseSettings: .settings(
            configurations: [
                .debug(name: "Test"),
                .debug(name: "ODI"),
                .release(name: "Prod")
            ]
        )
//        targetSettings: [:]
    ),
    platforms: [.iOS]
)
