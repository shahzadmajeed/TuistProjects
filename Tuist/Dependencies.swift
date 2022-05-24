import ProjectDescription
import ProjectDescriptionHelpers

// Using XCConfig based build settings for dependencies requires XCConfig files to be at a different path
// Not sure why tuist is looking for XCConfigs at a different path than specified but for now you can use
// Build Configuration without XCConfigs

//let projectSettings: Settings = .settings(configurations: BuildConfiguration.projectBuildConfigurations)
//
let enabledConfiguration: ProjectDescription.Project.ProjectConfiguration = .configuration(
    options: .options(automaticSchemesOptions: .enabled(codeCoverageEnabled: true),
                      developmentRegion: "en",
                      disableBundleAccessors: false,
                      disableShowEnvironmentVarsInScriptPhases: false,
                      disableSynthesizedResourceAccessors: false,
                      textSettings: .textSettings(),
                      xcodeProjectName: nil),
    resourceSynthesizers: .default)
//
//let disabledConfiguration: ProjectDescription.Project.ProjectConfiguration = .configuration(
//    options: .options(automaticSchemesOptions: .disabled,
//                      developmentRegion: "en",
//                      disableBundleAccessors: true,
//                      disableShowEnvironmentVarsInScriptPhases: true,
//                      disableSynthesizedResourceAccessors: true,
//                      textSettings: .textSettings(),
//                      xcodeProjectName: nil),
//    resourceSynthesizers: [])

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .local(path: .relativeToRoot("Projects/SPMModules"))
        ],
        // productTypes: ["Feature1": .dynamicLibrary],
        baseSettings: .settings(
            configurations: [
                .debug(name: "Test"),
                .debug(name: "ODI"),
                .release(name: "Prod")
            ]
        ),
        projectConfigurations: [
            //"*": enabledConfiguration
            
            "SPMModules": enabledConfiguration,
//            "Kingfisher": disabledConfiguration,  // Default behavior. No need to specify
//            "SnapKit": disabledConfiguration // Default behavior. No need to specify
//             
        ]
    ),
    platforms: [.iOS]
)
