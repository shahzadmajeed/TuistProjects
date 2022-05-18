import ProjectDescription

let config: Config = .standard

/// MARK:-  Config & Options Support
extension Config {
    
    static let standard: Config = .config()
    
    static let cache: Cache = .cache(profiles: [simDebugProfile, simReleaseProfile], path: nil)
    
    static let simReleaseProfile: Cache.Profile = .profile(name: "Simulator",
                                                           configuration: "Release",
                                                           device: "iPhone 13 Pro Max",
                                                           os: "15.4.0")
    
    static let simDebugProfile: Cache.Profile = .profile(name: "Simulator",
                                                         configuration: "Debug",
                                                         device: "iPhone 13 Pro Max",
                                                         os: "15.4.0")
    
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
