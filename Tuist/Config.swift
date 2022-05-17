import ProjectDescription

let config: Config = .standard

/// MARK:-  Config & Options Support
extension Config {
    
    static let standard: Config = .config()
    
    static func config(compatibleXcodeVersions: ProjectDescription.CompatibleXcodeVersions = .all,
                       cloud: ProjectDescription.Cloud? = nil,
                       cache: ProjectDescription.Cache? = nil,
                       swiftVersion: ProjectDescription.Version? = "5.5.0",
                       plugins: [ProjectDescription.PluginLocation] = [],
                       generationOptions: ProjectDescription.Config.GenerationOptions = .options()) -> Config {
        
        Config(compatibleXcodeVersions: compatibleXcodeVersions,
               cloud: cloud,
               cache: cache,
               swiftVersion: swiftVersion,
               plugins: plugins,
               generationOptions: generationOptions)
    }
}
