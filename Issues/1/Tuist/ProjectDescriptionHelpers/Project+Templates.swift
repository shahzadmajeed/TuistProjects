import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String,
                           platform: Platform,
                           deploymentTarget: DeploymentTarget,
                           additionalTargets: [String: [TargetDependency]],
                           externalDependencies:[String]) -> Project {
        
        let dependencies: [TargetDependency] =
        additionalTargets
            .keys
            .map { .target(name: $0) } +
        externalDependencies
            .map { .external(name: $0) }
        
        var targets = makeAppTargets(name: name,
                                     platform: platform,
                                     deploymentTarget: deploymentTarget,
                                     dependencies: dependencies)
        
        targets += additionalTargets.flatMap { (target, dependencies) in
            makeFrameworkTargets(name: target,
                                 platform: platform,
                                 deploymentTarget: deploymentTarget,
                                 dependencies: dependencies)
        }
        
        return Project(name: name,
                       organizationName: "tuist.io",
//                       packages: [
//                        .local(path: .relativeToRoot("Projects/Thor")),
//                        .remote(url: "https://github.com/Alamofire/Alamofire",
//                                requirement: .upToNextMajor(from: "5.0.0"))
//                       ],
                       targets: targets,
                       resourceSynthesizers: .default)
    }

    // MARK: - Private

    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(name: String,
                                             platform: Platform,
                                             deploymentTarget: DeploymentTarget,
                                             dependencies: [TargetDependency]) -> [Target] {
        let sources = Target(name: name,
                             platform: platform,
                product: .framework,
                bundleId: "io.tuist.\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Targets/\(name)/Sources/**"],
                resources: ["Targets/\(name)/Resources/**"],
                dependencies: dependencies)
        let tests = Target(name: "\(name)Tests",
                           platform: platform,
                product: .unitTests,
                bundleId: "io.tuist.\(name)Tests",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Targets/\(name)/Tests/**"],
                resources: [],
                dependencies: [.target(name: name)])
        return [sources, tests]
    }

    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String,
                                       platform: Platform,
                                       deploymentTarget: DeploymentTarget,
                                       dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
            ]

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "io.tuist.\(name)",
            deploymentTarget: deploymentTarget,
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "io.tuist.\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
        ])
        return [mainTarget, testTarget]
    }
}
