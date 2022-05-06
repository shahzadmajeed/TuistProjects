import ProjectDescription
import ProjectDescriptionHelpers

/*
                +-------------+
                |             |
                |     App     | Contains TuistLocalPackageIssue App target and TuistLocalPackageIssue unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

let projectName = "Workbench"

let kitTarget = projectName.appending("Kit")
let kitTargetDependencies: [TargetDependency] = ["Core", "Networking", "Kingfisher", "Alamofire"].map { .external(name: $0) }

let uiTarget = projectName.appending("UI")
let uiTargetDependencies: [TargetDependency] = [.target(name: kitTarget)] + ["Core", "Styles", "Components", "SnapKit", "Kingfisher", "MenuWidget", "WebBrowserKit"].map { .external(name: $0) }

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: projectName,
                          platform: .iOS,
                          deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone, .ipad]),
                          additionalTargets: [
                            kitTarget: kitTargetDependencies,
                            uiTarget: uiTargetDependencies
                          ],
                          externalDependencies: [
                            "Kingfisher",
                            "Alamofire",
                            "SnapKit",
                            "WebBrowserKit"
                          ])
