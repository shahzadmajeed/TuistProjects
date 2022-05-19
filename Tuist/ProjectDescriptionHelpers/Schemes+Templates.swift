//
//  Scheme+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Shahzad Majeed on 5/11/22.
//

import ProjectDescription

public enum BuildConfiguration: String, CaseIterable {
    
    case test = "Test"
    
    case prod = "Prod"
    
    case odi = "ODI"
    
    public var configName: ConfigurationName {
        .configuration(rawValue)
    }
    
    public var projectXCConfigPath: Path {
        // TODO: Move it to Specs
        .relativeToRoot("XCConfigs/Project-\(rawValue).xcconfig")
    }
    
    public var targetXCConfigPath: Path {
        // TODO: Move it to Specs
        .relativeToRoot("XCConfigs/App-Target-\(rawValue).xcconfig")
    }
    
    public static var appBuildConfigurations: [Configuration] {
        BuildConfiguration.allCases.map {
            $0.buildConfiguration(path: $0.targetXCConfigPath)
        }
    }
    
    public static var projectBuildConfigurations: [Configuration] {
        BuildConfiguration.allCases.map {
            $0.buildConfiguration(path: $0.projectXCConfigPath)
        }
    }
    
    public func buildConfiguration(_ configName: ConfigurationName? = nil, path: Path) -> Configuration {
        switch self {
            case .test, .odi:
                return .debug(name: configName ?? self.configName, xcconfig: path)
            case .prod:
                return .release(name: configName ?? self.configName, xcconfig: path)
        }
    }
}

public extension Scheme {
    
    /// TODO: Enhance this based on real generation time environments
    enum BuildEnvironment: String, CaseIterable {
        
        /// Debug build pointed to www.api.draftkingstest.com
        case test = "Test"
        
        /// Release build pointed to www.draftkings.com
        case prod = "Prod"
        
        /// Debug build pointing to www.{ODI-NAME}.api.draftkingstest.com
        case odi = "ODI"
        
        public var buildConfig: BuildConfiguration {
            switch self {
                case .odi: return .odi
                case .test: return .test
                case .prod: return .prod
            }
        }
        public func schemeName(for target: String) -> String {
            "\(target)-\(rawValue)"
        }
    }
    
    static func test(for target: String) -> Scheme {
        scheme(for: .test, target: target)
    }
    
    static func prod(for target: String) -> Scheme {
        scheme(for: .prod, target: target)
    }
    
    static func scheme(for env: BuildEnvironment, target: String) -> Scheme {
        
        // Scheme only uses ConfigurationName to identify which Configuration should be used
        // All supported Configurations are attached to the Project/Target separately
        
        let config = env.buildConfig.configName
        
        return .scheme(name: env.schemeName(for: target),
                       shared: true,
                       buildAction: .buildAction(targets: [.init(stringLiteral: target), /*.reference(Target.testTargetName(target))*/]), // Do we want to build test target as well? It will increase build time
                       testAction: .targets([.init(stringLiteral: target)],
                                            configuration: BuildConfiguration.test.configName),
                       runAction: .runAction(configuration: config),
                       archiveAction: .archiveAction(configuration: config),
                       profileAction: .profileAction(configuration: config),
                       analyzeAction: .analyzeAction(configuration: config)
        )
    }
    
    static func allSchemes(target: String) -> [Scheme] {
        BuildEnvironment
            .allCases
            .map { scheme(for: $0, target: target) }
    }
    
    static func allTestsScheme(_ schemeName: String, targets: [String]) -> Scheme {
        .scheme(name: schemeName,
                buildAction: .buildAction(targets: targets.map { .init(stringLiteral: $0) }),
                testAction: .targets(targets.map { .init(stringLiteral: $0) },
                                     configuration: BuildConfiguration.test.configName))
    }
    
    static func scheme(name: String,
                       shared: Bool = true,
                       hidden: Bool = false,
                       buildAction: ProjectDescription.BuildAction? = nil,
                       testAction: ProjectDescription.TestAction? = nil,
                       runAction: ProjectDescription.RunAction? = nil,
                       archiveAction: ProjectDescription.ArchiveAction? = nil,
                       profileAction: ProjectDescription.ProfileAction? = nil,
                       analyzeAction: ProjectDescription.AnalyzeAction? = nil) -> Scheme {
        
        Scheme(name: name,
               shared: shared,
               hidden: hidden,
               buildAction: buildAction,
               testAction: testAction,
               runAction: runAction,
               archiveAction: archiveAction,
               profileAction: profileAction,
               analyzeAction: analyzeAction)
    }
}
