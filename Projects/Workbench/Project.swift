import ProjectDescription
import ProjectDescriptionHelpers

// Single target project i.e .app
let project = Project.app(name: "Workbench",
                          platform: .iOS,
                          deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone, .ipad]),
                          additionalTargets: [:],
                          externalDependencies: ["Feature1", "SnapKit"])
