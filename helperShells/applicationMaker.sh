function makeMainApp() {
  projectName=$1
  mkdir $projectName && cd $projectName

  mkdir Support && cd Support
  mkdir InfoPlist && cd InfoPlist

  touch Info.plist

  echo '<?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
  <dict>
  	<key>CFBundleDevelopmentRegion</key>
  	<string>$(DEVELOPMENT_LANGUAGE)</string>
  	<key>CFBundleExecutable</key>
  	<string>$(EXECUTABLE_NAME)</string>
  	<key>CFBundleIdentifier</key>
  	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
  	<key>CFBundleInfoDictionaryVersion</key>
  	<string>6.0</string>
  	<key>CFBundleName</key>
  	<string>$(PRODUCT_NAME)</string>
  	<key>CFBundlePackageType</key>
  	<string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
  	<key>CFBundleShortVersionString</key>
  	<string>1.0</string>
  	<key>CFBundleVersion</key>
  	<string>1</string>
  	<key>LSRequiresIPhoneOS</key>
  	<true/>
  	<key>UIApplicationSceneManifest</key>
  	<dict>
  		<key>UIApplicationSupportsMultipleScenes</key>
  		<false/>
  		<key>UISceneConfigurations</key>
  		<dict>
  			<key>UIWindowSceneSessionRoleApplication</key>
  			<array>
  				<dict>
  					<key>UISceneConfigurationName</key>
  					<string>Default Configuration</string>
  					<key>UISceneDelegateClassName</key>
  					<string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
  				</dict>
  			</array>
  		</dict>
  	</dict>
  	<key>UIApplicationSupportsIndirectInputEvents</key>
  	<true/>
  	<key>UILaunchStoryboardName</key>
  	<string>LaunchScreen</string>
  	<key>UIRequiredDeviceCapabilities</key>
  	<array>
  		<string>armv7</string>
  	</array>
  	<key>UISupportedInterfaceOrientations</key>
  	<array>
  		<string>UIInterfaceOrientationPortrait</string>
  		<string>UIInterfaceOrientationLandscapeLeft</string>
  		<string>UIInterfaceOrientationLandscapeRight</string>
  	</array>
  	<key>UISupportedInterfaceOrientations~ipad</key>
  	<array>
  		<string>UIInterfaceOrientationPortrait</string>
  		<string>UIInterfaceOrientationPortraitUpsideDown</string>
  		<string>UIInterfaceOrientationLandscapeLeft</string>
  		<string>UIInterfaceOrientationLandscapeRight</string>
  	</array>
  </dict>
  </plist>
  ' > Info.plist

  cd ../
  mkdir BridgingHeader
  cd BridgingHeader
  touch Common.h
  echo '#ifndef Common_h
  #define Common_h
  #import <Foundation/Foundation.h>
  #import <UIKit/UIKit.h>

  #endif /* Common_h */' > Common.h
  echo "#ifndef $projectName-Bridging-Header.h
  #define $projectName-Bridging-Header.h

  #import "Common.h"
  #endif /* $projectName-Bridging-Header.h */
  " > $projectName-Bridging-Header.h

  cd ../../
  mkdir Targets
  cd Targets

  mkdir $projectName
  cd $projectName

  mkdir Resources
  cd Resources

  mkdir Colors.xcassets
  cd Colors.xcassets

  touch Contents.json
  echo '{
    "info" : {
      "author" : "xcode",
      "version" : 1
    }
  }' > Contents.json
  mkdir DefaultColor.colorset
  cd DefaultColor.colorset
  touch Contents.json
  echo '{
    "colors" : [
      {
        "color" : {
          "color-space" : "srgb",
          "components" : {
            "alpha" : "1.000",
            "blue" : "1.000",
            "green" : "1.000",
            "red" : "1.000"
          }
        },
        "idiom" : "universal"
      },
      {
        "appearances" : [
          {
            "appearance" : "luminosity",
            "value" : "dark"
          }
        ],
        "color" : {
          "color-space" : "srgb",
          "components" : {
            "alpha" : "1.000",
            "blue" : "1.000",
            "green" : "1.000",
            "red" : "1.000"
          }
        },
        "idiom" : "universal"
      }
    ],
    "info" : {
      "author" : "xcode",
      "version" : 1
    }
  }
  ' > Contents.json

  cd ../../

  touch emptyJson.json
  echo '{}' > emptyJson.json

  touch LaunchScreen.storyboard
  echo '<?xml version="1.0" encoding="UTF-8"?>
  <document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="21701" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" launchScreen="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES" initialViewController="Y6W-OH-hqX">
      <device id="retina6_12" orientation="portrait" appearance="light"/>
      <dependencies>
          <deployment identifier="iOS"/>
          <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="21678"/>
          <capability name="Safe area layout guides" minToolsVersion="9.0"/>
          <capability name="System colors in document resources" minToolsVersion="11.0"/>
          <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
      </dependencies>
      <scenes>
          <!--View Controller-->
          <scene sceneID="s0d-6b-0kx">
              <objects>
                  <viewController id="Y6W-OH-hqX" sceneMemberID="viewController">
                      <view key="view" contentMode="scaleToFill" id="5EZ-qb-Rvc">
                          <rect key="frame" x="0.0" y="0.0" width="393" height="852"/>
                          <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                          <subviews>
                              <label opaque="NO" userInteractionEnabled="NO" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" text="LaunchScreen" textAlignment="natural" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="qrG-1m-8XZ">
                                  <rect key="frame" x="141.66666666666666" y="415.66666666666669" width="110" height="21"/>
                                  <fontDescription key="fontDescription" type="system" pointSize="17"/>
                                  <nil key="textColor"/>
                                  <nil key="highlightedColor"/>
                              </label>
                          </subviews>
                          <viewLayoutGuide key="safeArea" id="vDu-zF-Fre"/>
                          <color key="backgroundColor" systemColor="systemBackgroundColor"/>
                          <constraints>
                              <constraint firstItem="qrG-1m-8XZ" firstAttribute="centerY" secondItem="5EZ-qb-Rvc" secondAttribute="centerY" id="kpJ-G9-AaY"/>
                              <constraint firstItem="qrG-1m-8XZ" firstAttribute="centerX" secondItem="5EZ-qb-Rvc" secondAttribute="centerX" id="wjy-0y-9LN"/>
                          </constraints>
                      </view>
                  </viewController>
                  <placeholder placeholderIdentifier="IBFirstResponder" id="Ief-a0-LHa" userLabel="First Responder" customClass="UIResponder" sceneMemberID="firstResponder"/>
              </objects>
              <point key="canvasLocation" x="131" y="-27"/>
          </scene>
      </scenes>
      <resources>
          <systemColor name="systemBackgroundColor">
              <color white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
          </systemColor>
      </resources>
  </document>
  ' > LaunchScreen.storyboard

  mkdir Images.xcassets
  cd Images.xcassets
  touch Contents.json
  echo '{
    "info" : {
      "author" : "xcode",
      "version" : 1
    }
  }' > Contents.json
  mkdir AppIcon.appiconset
  cd AppIcon.appiconset
  touch Contents.json
  echo '{
    "images" : [
      {
        "filename" : "appIcon.jpg",
        "idiom" : "universal",
        "platform" : "ios",
        "size" : "1024x1024"
      }
    ],
    "info" : {
      "author" : "xcode",
      "version" : 1
    }
  }
  ' > Contents.json

  cd $GeneratorRoot
  cp "temp/appIcon.jpg" "TuistProject/Projects/$projectName/Targets/$projectName/Resources/Images.xcassets/AppIcon.appiconset/"


  # $projectName - Sources
  cd "TuistProject/Projects/$projectName/Targets/$projectName"
  mkdir Sources && cd Sources

  # AppDelegate, SceneDelegate, ViewController
  makeAppDelegate
  makeSceneDelegate

  touch ViewController.swift
  echo 'import UIKit

  class ViewController: UIViewController {
    
    override func viewDidLoad() {
      self.view.backgroundColor = .white
    }
  }
  ' > ViewController.swift

  cd ../

  mkdir TestResources
  cd TestResources
  touch emptyJson.json
  echo '{}' > emptyJson.json
  cd ../

  mkdir Tests
  cd Tests

  touch SampleTests.json
  echo 'import XCTest

  class SampleTests: XCTestCase {
    override func setUpWithError() throws {
    }
    override func tearDownWithError() throws {
    }
  }
  ' > SampleTests.json
  cd ../

  # XCConfigs
  mkdir XCConfigs
  cd XCConfigs

  touch $projectName.xcconfig
  echo 'ASSETCATALOG_COMPILER_APPICON_NAME=AppIcon
ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME=AccentColor
CODE_SIGN_IDENTITY=iPhone Developer
IPHONEOS_DEPLOYMENT_TARGET=15.0
MARKETING_VERSION=1.0.0
PRODUCT_NAME=$(TARGET_NAME)
SUPPORTS_MACCATALYST=NO
SWIFT_VERSION=5.0
TARGETED_DEVICE_FAMILY=1
OTHER_LDFLAGS = $(OTHER_LDFLAGS) -ObjC
CODE_SIGN_STYLE = Manual
' > $projectName.xcconfig

  touch Debug.xcconfig
  echo "SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG
  #include \"$projectName.xcconfig"\" > Debug.xcconfig

  touch Release.xcconfig
  echo "#include \"$projectName.xcconfig\"" > Release.xcconfig

  cd ../../../

  touch Project.swift
  echo "import ProjectDescription
  import ProjectDescriptionHelpers

  let projectName = \"$projectName\"
  let project = Project.makeModule(
    name: projectName,
    platform: .iOS,
    product: .app,
    dependencies: [],
    bridgingHeaderPath: \"Support/BridgingHeader/$projectName-Bridging-Header.h\",
    customInfoPlist: .file(path: \"Support/InfoPlist/Info.plist\"),
    additionalTargets: []
  )" > Project.swift

}

function makeIncludeOnlyApplication() { 
  projectName=$1
  
  mkdir $projectName && cd $projectName
  includeResult=true
  touch Project.swift
  echo "import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = \"$projectName\"
let project = Project.makeModule(
  name: projectName,
  product: .app,
  additionalTargets: [],
  isIncludeOnly: true
)
" > Project.swift
}

function makeIncludeApplication() { 
  projectName=$1
  
  currPath=$(pwd)
  mkdir $projectName && cd $projectName
  mkdir Targets && cd Targets
  mkdir $projectName && cd $projectName
  mkdir Sources && cd Sources
  makeAppDelegate
  makeSceneDelegate
  cd ../
  mkdir Resources && cd Resources
  touch sample.json
  echo '{}' > sample.json
  cd $currPath
  cd $projectName

  touch Project.swift
  echo "import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = \"$projectName\"
let project = Project.makeModule(
  name: projectName,
  product: .app,
  additionalTargets: [],
  isIncludeOnly: false
)
" > Project.swift
}


function makeAppDelegate() { 
  touch AppDelegate.swift
  echo 'import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
}

' > AppDelegate.swift

}

function makeSceneDelegate() {
  touch SceneDelegate.swift
  echo 'import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    let mainViewController = ViewController()
    
    window?.rootViewController = mainViewController
    window?.makeKeyAndVisible()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) { }
  func sceneDidBecomeActive(_ scene: UIScene) { }
  func sceneWillResignActive(_ scene: UIScene) { }
  func sceneWillEnterForeground(_ scene: UIScene) { }
  func sceneDidEnterBackground(_ scene: UIScene) { }
}
' > SceneDelegate.swift
}