import ProjectDescription

    extension Project {
    
    public static func makeFrameworkTargets(
        name: String,
        frameworkType: Product = .staticFramework,
        baseBundleId: String = "com.tuistTemplate",
        customInfoPlist: InfoPlist,
        dependencies: [TargetDependency],
        testDependencies: [TargetDependency]
    ) -> [Target] {
        
        let scripts: [TargetScript] = [
        TargetScript.makeScript(
            order: .pre,
            scriptPath: "../Tool/Lint/swiftlint --config \"../Tool/Lint/swiftlint.yml\"",
            name: "Lint"
        )
        ]
        
        let mainTarget = Target(
        name: name,
        platform: .iOS,
        product: frameworkType,
        bundleId: "\(baseBundleId).\(name)",
        infoPlist: customInfoPlist,
        sources: ["Targets/\(name)/Sources/**"],
        resources: ["Targets/\(name)/Resources/**"],
        scripts: scripts,
        dependencies: dependencies
        )
        
        let testTarget = Target(
        name: "\(name)Tests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "\(baseBundleId).\(name)Tests",
        infoPlist: .default,
        sources: ["Targets/\(name)/Sources/**"],
        resources: ["Targets/\(name)/Resources/**"],
        dependencies: [.target(name: name)] + testDependencies
        )
        
        let sampleApp = Target(
        name: "\(name)SampleApp",
        platform: .iOS,
        product: .app,
        bundleId: "\(baseBundleId).\(name)SampleApp",
        infoPlist: customInfoPlist,
        sources: ["Targets/\(name)/Sources/**"],
        resources: ["Targets/\(name)/Resources/**"],
        dependencies: [.target(name: name)]
        )
        
        return [mainTarget, testTarget, sampleApp]
    }
    }
