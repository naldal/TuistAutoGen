#!/bin/bash

# 테스트: 초기화
mv TuistProject/Projects/Tool/Lint temp/
mv TuistProject/Projects/Core/Targets/Core/Resources/Images.xcassets/AppIcon.appiconset/appIcon.jpg temp/ 
rm -rf TuistProject

# # 폴더를 생성합니다
# mkdir TuistProject && cd TuistProject

# # Tuist 프로젝트를 초기화합니다
# tuist init

# # Configs 구성
# cd Tuist
# echo 'import ProjectDescription

# let config = Config(
    
# )
# ' > Config.swift
# cd ../

# # 불필요한 폴더를 제거합니다
# rm -rf Plugins
# rm -rf Targets

# # Workspace.swift 파일을 생성하고 덮어쓰기를 합니다
# echo 'import ProjectDescription

# let workspaceName = "workspace"
# let workspace = Workspace(
#   name: workspaceName,
#   projects: [
#     "Projects/*"
#   ]
# )' > Workspace.swift

# # 기본 Project.swift 제거
# rm Project.swift

# # Projects 폴더를 생성합니다
# mkdir Projects

# # Tuist - ProjectDescriptionHelpers - Project+Templates.swift 에 코드를 덮어쓰기한다
# cd Tuist && cd ProjectDescriptionHelpers

# echo 'import ProjectDescription

# public extension Project {
 
#   static func makeModule(
#     name: String,
#     platform: Platform = .iOS,
#     product: Product,
#     baseBundleId: String = "com.tuistTemplate",
#     organizationName: String = "organizationName",
#     packages: [Package] = [],
#     deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "15.0", devices: [.iphone]),
#     dependencies: [TargetDependency] = [],
#     testDependencies: [TargetDependency] = [],
#     bridgingHeaderPath: String? = nil,
#     customInfoPlist: InfoPlist = .default,
#     additionalTargets: [String],
#     isIncludeOnly: Bool = false
#   ) -> Project {
    
#     var originName: String {
#       return "Core"
#     }
    
#     // MARK: - Targets
    
#     let targetAdditionalSourcePath: [String] = [
#       "../\(originName)/Targets/\(originName)/Sources/**"
#     ]
    
#     let targetAdditionalResourcePath: [String] = [
#       "../\(originName)/Targets/\(originName)/Resources/**"
#     ]
    
#     let targets: [Target] = self.makeTargets(
#       targetName: name,
#       originName: originName,
#       platform: platform,
#       product: product,
#       baseBundleId: baseBundleId,
#       deploymentTarget: deploymentTarget,
#       dependencies: dependencies,
#       testDependencies: testDependencies,
#       additionalSourcePaths: targetAdditionalSourcePath,
#       additionalResourcePaths: targetAdditionalResourcePath,
#       isIncludeOnly: isIncludeOnly
#     )
    
    
#     // MARK: - Build settings
    
#     var baseSetting: ProjectDescription.SettingsDictionary {
#       if let bridgingHeaderPath {
#         return ["SWIFT_OBJC_BRIDGING_HEADER": SettingValue(stringLiteral: bridgingHeaderPath)]
#       }
#       return [:]
#     }
    
#     let settings: Settings = .settings(
#       base: [:],
#       configurations: [
#         .debug(
#           name: .debug,
#           settings: baseSetting,
#           xcconfig: "../\(originName)/Targets/\(originName)/XCConfigs/Debug.xcconfig"
#         ),
#         .release(
#           name: .release,
#           settings: baseSetting,
#           xcconfig: "../\(originName)/Targets/\(originName)/XCConfigs/Release.xcconfig"
#         )
#       ],
#       defaultSettings: .recommended
#     )

#     return Project(
#       name: name,
#       organizationName: organizationName,
#       packages: packages,
#       settings: settings,
#       targets: targets,
#       resourceSynthesizers: []
#     )
#   }
  
  
#   // MARK: - make multiple targets
  
#   static func makeTargets(
#     targetName: String,
#     originName: String,
#     platform: Platform,
#     product: Product,
#     baseBundleId: String,
#     deploymentTarget: DeploymentTarget?,
#     dependencies: [TargetDependency],
#     testDependencies: [TargetDependency],
#     additionalSourcePaths: [String],
#     additionalResourcePaths: [String],
#     isIncludeOnly: Bool
#   ) -> [Target] {
    
#     let sources: SourceFilesList = {
#       if targetName != originName {
#         let globs: [SourceFileGlob] = {
#           var returnValue: [SourceFileGlob] = []
#           if isIncludeOnly == false {
#             returnValue.append(SourceFileGlob.glob("../\(targetName)/Targets/\(targetName)/Sources/**"))
#           }
#           for additionalSourcePath in additionalSourcePaths {
#             returnValue.append(.glob(
#               Path(additionalSourcePath),
#               excluding: [
#                 "../\(originName)/Targets/\(originName)/Sources/AppDelegate.swift",
#                 "../\(originName)/Targets/\(originName)/Sources/SceneDelegate.swift"
#               ]
#             ))
#           }
#           return returnValue
#         }()
#         return SourceFilesList(globs: globs)
#       } else {
#         var returnValue: [String] = additionalSourcePaths
#         returnValue.append("../\(originName)/Targets/\(originName)/Sources/**")
#         return SourceFilesList(globs: returnValue)
#       }
#     }()
    
#     let resources: ResourceFileElements = {
#       if targetName != originName {
#         var returnValue: [String] = additionalResourcePaths
#         if isIncludeOnly == false {
#           returnValue.append("../\(targetName)/Targets/\(targetName)/Resources/**")
#         }
#         var elements: [ResourceFileElement] = []
#         for item in returnValue {
#           elements.append(.init(stringLiteral: item))
#         }
#         return ResourceFileElements(resources: elements)
#       } else {
#         var returnValue: [String] = additionalResourcePaths
#         returnValue.append("../\(originName)/Targets/\(originName)/Resources/**")
#         var elements: [ResourceFileElement] = []
#         for item in returnValue {
#           elements.append(.init(stringLiteral: item))
#         }
#         return ResourceFileElements(resources: elements)
#       }
#     }()
    
#     // add your own scripts
#     let scripts: [TargetScript] = [
#       TargetScript.makeScript(
#         order: .pre,
#         scriptPath: "../Tool/Lint/swiftlint --config \"../Tool/Lint/swiftlint.yml\"",
#         name: "Lint"
#       )
#     ]
    
#     let mainTarget = Target(
#       name: targetName,
#       platform: platform,
#       product: product,
#       bundleId: "\(baseBundleId).\(targetName)",
#       deploymentTarget: deploymentTarget,
#       infoPlist: .file(path: "../\(originName)/Support/InfoPlist/Info.plist"),
#       sources: sources,
#       resources: resources,
#       scripts: scripts,
#       dependencies: dependencies
#     )
    
#     let testTarget = Target(
#       name: "\(targetName)Tests",
#       platform: platform,
#       product: .unitTests,
#       bundleId: "\(baseBundleId).\(targetName)Tests",
#       deploymentTarget: deploymentTarget,
#       infoPlist: .file(path: "../\(originName)/Support/InfoPlist/Info.plist"),
#       sources: ["../\(originName)/Targets/\(originName)/Tests/**"],
#       resources: ["../\(originName)/Targets/\(originName)/TestResources/**"],
#       dependencies: testDependencies
#     )
    
#     return [mainTarget, testTarget]
#   }
# }' > Project+Templates.swift

# # Tuist/ProjectDescriptionHelpers/Project+Framework.swift 를 만든다
# touch Project+Framework.swift
# echo 'import ProjectDescription

# extension Project {
  
#   public static func makeFrameworkTargets(
#     name: String,
#     frameworkType: Product = .staticFramework,
#     baseBundleId: String = "com.tuistTemplate",
#     customInfoPlist: InfoPlist,
#     dependencies: [TargetDependency],
#     testDependencies: [TargetDependency]
#   ) -> [Target] {
    
#     let scripts: [TargetScript] = [
#       TargetScript.makeScript(
#         order: .pre,
#         scriptPath: "../Tool/Lint/swiftlint --config \"../Tool/Lint/swiftlint.yml\"",
#         name: "Lint"
#       )
#     ]
    
#     let mainTarget = Target(
#       name: name,
#       platform: .iOS,
#       product: frameworkType,
#       bundleId: "\(baseBundleId).\(name)",
#       infoPlist: customInfoPlist,
#       sources: ["Targets/\(name)/Sources/**"],
#       resources: ["Targets/\(name)/Resources/**"],
#       scripts: scripts,
#       dependencies: dependencies
#     )
    
#     let testTarget = Target(
#       name: "\(name)Tests",
#       platform: .iOS,
#       product: .unitTests,
#       bundleId: "\(baseBundleId).\(name)Tests",
#       infoPlist: .default,
#       sources: ["Targets/\(name)/Sources/**"],
#       resources: ["Targets/\(name)/Resources/**"],
#       dependencies: [.target(name: name)] + testDependencies
#     )
    
#     let sampleApp = Target(
#       name: "\(name)SampleApp",
#       platform: .iOS,
#       product: .app,
#       bundleId: "\(baseBundleId).\(name)SampleApp",
#       infoPlist: customInfoPlist,
#       sources: ["Targets/\(name)/Sources/**"],
#       resources: ["Targets/\(name)/Resources/**"],
#       dependencies: [.target(name: name)]
#     )
    
#     return [mainTarget, testTarget, sampleApp]
#   }
# }' > Project+Framework.swift

# # Tuist/ProjectDescriptionHelpers/Project+Scripts.swift 를 만든다
# touch Project+Scripts.swift
# echo 'import ProjectDescription

# extension TargetScript {
  
#   enum RunOrderType {
#     case pre
#     case post
#   }
  
#   static func makeScript(order: RunOrderType, scriptPath: String, name: String) -> TargetScript {
#     switch order {
#     case .pre:
#       return .pre(script: scriptPath, name: name)
#     case .post:
#       return .post(script: scriptPath, name: name)
#     }
#   }
# }' > Project+Scripts.swift

# # Tuist/ProjectDescriptionHelpers/Project+Dependency.swift 를 만든다
# touch Project+Dependency.swift
# echo 'import ProjectDescription

# public extension TargetDependency {
#   static let quick: TargetDependency = .external(name: "Quick")
#   static let nimble: TargetDependency = .external(name: "Nimble")
# }' > Project+Dependency.swift

# # 다시 루트 폴더로 돌아간다
# cd ../../

# # Projects 구성시작
# cd Projects

# # Tool 폴더를 만든다
# mkdir Tool && cd Tool

# # Tool/Lint 폴더를 구성
# cd ../../../
# mv temp/Lint TuistProject/Projects/Tool

# # Core 파일 구성
# cd TuistProject && cd Projects && mkdir Core && cd Core

# # Core - Support 파일을 구성
# mkdir Support
# cd Support

# # Core - Support - InfoPlist 파일을 구성
# mkdir InfoPlist
# cd InfoPlist
# touch Info.plist
# echo '<?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
# <dict>
# 	<key>CFBundleDevelopmentRegion</key>
# 	<string>$(DEVELOPMENT_LANGUAGE)</string>
# 	<key>CFBundleExecutable</key>
# 	<string>$(EXECUTABLE_NAME)</string>
# 	<key>CFBundleIdentifier</key>
# 	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
# 	<key>CFBundleInfoDictionaryVersion</key>
# 	<string>6.0</string>
# 	<key>CFBundleName</key>
# 	<string>$(PRODUCT_NAME)</string>
# 	<key>CFBundlePackageType</key>
# 	<string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
# 	<key>CFBundleShortVersionString</key>
# 	<string>1.0</string>
# 	<key>CFBundleVersion</key>
# 	<string>1</string>
# 	<key>LSRequiresIPhoneOS</key>
# 	<true/>
# 	<key>UIApplicationSceneManifest</key>
# 	<dict>
# 		<key>UIApplicationSupportsMultipleScenes</key>
# 		<false/>
# 		<key>UISceneConfigurations</key>
# 		<dict>
# 			<key>UIWindowSceneSessionRoleApplication</key>
# 			<array>
# 				<dict>
# 					<key>UISceneConfigurationName</key>
# 					<string>Default Configuration</string>
# 					<key>UISceneDelegateClassName</key>
# 					<string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
# 				</dict>
# 			</array>
# 		</dict>
# 	</dict>
# 	<key>UIApplicationSupportsIndirectInputEvents</key>
# 	<true/>
# 	<key>UILaunchStoryboardName</key>
# 	<string>LaunchScreen</string>
# 	<key>UIRequiredDeviceCapabilities</key>
# 	<array>
# 		<string>armv7</string>
# 	</array>
# 	<key>UISupportedInterfaceOrientations</key>
# 	<array>
# 		<string>UIInterfaceOrientationPortrait</string>
# 		<string>UIInterfaceOrientationLandscapeLeft</string>
# 		<string>UIInterfaceOrientationLandscapeRight</string>
# 	</array>
# 	<key>UISupportedInterfaceOrientations~ipad</key>
# 	<array>
# 		<string>UIInterfaceOrientationPortrait</string>
# 		<string>UIInterfaceOrientationPortraitUpsideDown</string>
# 		<string>UIInterfaceOrientationLandscapeLeft</string>
# 		<string>UIInterfaceOrientationLandscapeRight</string>
# 	</array>
# </dict>
# </plist>
# ' > Info.plist

# # Core - Support - BridgingHeader 파일을 구성
# cd ../
# mkdir BridgingHeader
# cd BridgingHeader
# touch Common.h
# echo '#ifndef Common_h
# #define Common_h
# #import <Foundation/Foundation.h>
# #import <UIKit/UIKit.h>

# #endif /* Common_h */' > Common.h
# echo '#ifndef Core-Bridging-Header.h
# #define Core-Bridging-Header.h

# #import "Common.h"
# #endif /* Core-Bridging-Header.h */
# ' > Core-Bridging-Header.h

# # Core - Target 이하 파일을 구성
# cd ../../
# mkdir Targets
# cd Targets

# mkdir Core
# cd Core

# # Core - Resources
# mkdir Resources
# cd Resources

# mkdir Colors.xcassets
# cd Colors.xcassets

# touch Contents.json
# echo '{
#   "info" : {
#     "author" : "xcode",
#     "version" : 1
#   }
# }' > Contents.json
# mkdir DefaultColor.colorset
# cd DefaultColor.colorset
# touch Contents.json
# echo '{
#   "colors" : [
#     {
#       "color" : {
#         "color-space" : "srgb",
#         "components" : {
#           "alpha" : "1.000",
#           "blue" : "1.000",
#           "green" : "1.000",
#           "red" : "1.000"
#         }
#       },
#       "idiom" : "universal"
#     },
#     {
#       "appearances" : [
#         {
#           "appearance" : "luminosity",
#           "value" : "dark"
#         }
#       ],
#       "color" : {
#         "color-space" : "srgb",
#         "components" : {
#           "alpha" : "1.000",
#           "blue" : "1.000",
#           "green" : "1.000",
#           "red" : "1.000"
#         }
#       },
#       "idiom" : "universal"
#     }
#   ],
#   "info" : {
#     "author" : "xcode",
#     "version" : 1
#   }
# }
# ' > Contents.json

# cd ../../

# touch emptyJson.json
# echo '{}' > emptyJson.json

# touch LaunchScreen.storyboard
# echo '<?xml version="1.0" encoding="UTF-8"?>
# <document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="21701" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" launchScreen="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES" initialViewController="Y6W-OH-hqX">
#     <device id="retina6_12" orientation="portrait" appearance="light"/>
#     <dependencies>
#         <deployment identifier="iOS"/>
#         <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="21678"/>
#         <capability name="Safe area layout guides" minToolsVersion="9.0"/>
#         <capability name="System colors in document resources" minToolsVersion="11.0"/>
#         <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
#     </dependencies>
#     <scenes>
#         <!--View Controller-->
#         <scene sceneID="s0d-6b-0kx">
#             <objects>
#                 <viewController id="Y6W-OH-hqX" sceneMemberID="viewController">
#                     <view key="view" contentMode="scaleToFill" id="5EZ-qb-Rvc">
#                         <rect key="frame" x="0.0" y="0.0" width="393" height="852"/>
#                         <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
#                         <subviews>
#                             <label opaque="NO" userInteractionEnabled="NO" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" text="LaunchScreen" textAlignment="natural" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="qrG-1m-8XZ">
#                                 <rect key="frame" x="141.66666666666666" y="415.66666666666669" width="110" height="21"/>
#                                 <fontDescription key="fontDescription" type="system" pointSize="17"/>
#                                 <nil key="textColor"/>
#                                 <nil key="highlightedColor"/>
#                             </label>
#                         </subviews>
#                         <viewLayoutGuide key="safeArea" id="vDu-zF-Fre"/>
#                         <color key="backgroundColor" systemColor="systemBackgroundColor"/>
#                         <constraints>
#                             <constraint firstItem="qrG-1m-8XZ" firstAttribute="centerY" secondItem="5EZ-qb-Rvc" secondAttribute="centerY" id="kpJ-G9-AaY"/>
#                             <constraint firstItem="qrG-1m-8XZ" firstAttribute="centerX" secondItem="5EZ-qb-Rvc" secondAttribute="centerX" id="wjy-0y-9LN"/>
#                         </constraints>
#                     </view>
#                 </viewController>
#                 <placeholder placeholderIdentifier="IBFirstResponder" id="Ief-a0-LHa" userLabel="First Responder" customClass="UIResponder" sceneMemberID="firstResponder"/>
#             </objects>
#             <point key="canvasLocation" x="131" y="-27"/>
#         </scene>
#     </scenes>
#     <resources>
#         <systemColor name="systemBackgroundColor">
#             <color white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
#         </systemColor>
#     </resources>
# </document>
# ' > LaunchScreen.storyboard

# mkdir Images.xcassets
# cd Images.xcassets
# touch Contents.json
# echo '{
#   "info" : {
#     "author" : "xcode",
#     "version" : 1
#   }
# }' > Contents.json
# mkdir AppIcon.appiconset
# cd AppIcon.appiconset
# touch Contents.json
# echo '{
#   "images" : [
#     {
#       "filename" : "appIcon.jpg",
#       "idiom" : "universal",
#       "platform" : "ios",
#       "size" : "1024x1024"
#     }
#   ],
#   "info" : {
#     "author" : "xcode",
#     "version" : 1
#   }
# }
# ' > Contents.json

# cd ../../../../../../../../
# echo $(pwd)
# mv temp/appIcon.jpg TuistProject/Projects/Core/Targets/Core/Resources/Images.xcassets/AppIcon.appiconset/


# # Core - Sources 폴더구성
# cd TuistProject/Projects/Core/Targets/Core
# mkdir Sources && cd Sources

# # AppDelegate, SceneDelegate, ViewController 생성
# touch AppDelegate.swift
# echo 'import UIKit

# @main
# class AppDelegate: UIResponder, UIApplicationDelegate {
	
# 	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
# 		return true
# 	}
	
# 	// MARK: UISceneSession Lifecycle
	
# 	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
# 		// Called when a new scene session is being created.
# 		// Use this method to select a configuration to create the new scene with.
# 		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
# 	}
	
# 	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
# 		// Called when the user discards a scene session.
# 		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
# 		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
# 	}
# }
# ' > AppDelegate.swift

# touch SceneDelegate.swift
# echo 'import UIKit

# class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
#   var window: UIWindow?
	
# 	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
#     guard let windowScene = (scene as? UIWindowScene) else { return }
#     window = UIWindow(windowScene: windowScene)
#     let mainViewController = ViewController()

#     window?.rootViewController = mainViewController
#     window?.makeKeyAndVisible()
# 	}
	
# 	func sceneDidDisconnect(_ scene: UIScene) { }
# 	func sceneDidBecomeActive(_ scene: UIScene) { }
# 	func sceneWillResignActive(_ scene: UIScene) { }
# 	func sceneWillEnterForeground(_ scene: UIScene) { }
# 	func sceneDidEnterBackground(_ scene: UIScene) { }
	
	
# }
# ' > SceneDelegate.swift

# touch ViewController.swift
# echo 'import UIKit

# class ViewController: UIViewController {
  
#   override func viewDidLoad() {
#     self.view.backgroundColor = .white
#   }
# }
# ' > ViewController.swift

# cd ../

# # Core - TestResources 폴더 구성
# mkdir TestResources
# cd TestResources
# touch emptyJson.json
# echo '{}' > emptyJson.json
# cd ../

# # Core - Tests
# mkdir Tests
# cd Tests

# touch SampleTests.json
# echo 'import XCTest

# class SampleTests: XCTestCase {
#   override func setUpWithError() throws {
#   }
#   override func tearDownWithError() throws {
#   }
# }
# ' > SampleTests.json
# cd ../

# # Core - XCConfigs
# mkdir XCConfigs
# cd XCConfigs

# touch Core.xcconfig
# echo 'ASSETCATALOG_COMPILER_APPICON_NAME=AppIcon
# ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME=AccentColor
# CODE_SIGN_IDENTITY=iPhone Developer
# IPHONEOS_DEPLOYMENT_TARGET=15.0
# MARKETING_VERSION=1.0.0
# PRODUCT_NAME=$(TARGET_NAME)
# SUPPORTS_MACCATALYST=NO
# SWIFT_VERSION=5.0
# TARGETED_DEVICE_FAMILY=1
# OTHER_LDFLAGS = $(OTHER_LDFLAGS) -ObjC
# CODE_SIGN_STYLE = Manual
# ' > Core.xcconfig

# touch Debug.xcconfig
# echo 'SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG
# #include "Core.xcconfig"' > Debug.xcconfig

# touch Release.xcconfig
# echo '#include "Core.xcconfig"' > Release.xcconfig

# cd ../../../
# echo $(pwd)

# # Core - Project.swift 를 만든다.
# touch Project.swift
# echo 'import ProjectDescription
# import ProjectDescriptionHelpers

# let projectName = "Core"
# let project = Project.makeModule(
#   name: projectName,
#   platform: .iOS,
#   product: .app,
#   dependencies: [],
#   bridgingHeaderPath: "Support/BridgingHeader/Core-Bridging-Header.h",
#   customInfoPlist: .file(path: "Support/InfoPlist/Info.plist"),
#   additionalTargets: []
# )' > Project.swift

# # Core 프로젝트 빌드
# tuist generate -n