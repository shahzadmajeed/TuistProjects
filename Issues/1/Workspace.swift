import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: "Metaverse-iOS",
    projects: [.relativeToRoot("Projects/**")],
    schemes: [],
    fileHeaderTemplate: nil,
    additionalFiles: [],
    generationOptions: .options()
)
