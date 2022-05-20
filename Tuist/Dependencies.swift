import ProjectDescription
import ProjectDescriptionHelpers

// Using XCConfig based build settings for dependencies requires XCConfig files to be at a different path
// Not sure why tuist is looking for XCConfigs at a different path than specified but for now you can use
// Build Configuration without XCConfigs

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
    ),
    platforms: [.iOS]
)
