function makeFramework() { 
  frameworkName=$1
  mkdir $frameworkName && cd $frameworkName

  mkdir Support && cd Support
  mkdir InfoPlist && cd InfoPlist

  touch "$frameworkName-Info.plist"
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
' > "$frameworkName-Info.plist"
  mkdir Targets && cd Targets
  cd ../../

  mkdir $frameworkName && cd $frameworkName
  

  mkdir {Sources,Resources}
  
  touch sample.swift
  echo 'sample' > ./Sources/sample.swift
  touch sample.json
  echo '{}' > ./Resources/sample.json

  mkdir -p TestHost/{Sources,Resources}
  touch sample.swift
  echo 'sample' > ./TestHost/Sources/sample.swift
  touch sample.json
  echo '{}' > ./TestHost//Resources/sample.json

  mkdir -p SampleApp/{Sources,Resources}
  touch sample.swift
  echo 'sample' > ./SampleApp/Sources/sample.swift
  touch sample.json
  echo '{}' > ./SampleApp//Resources/sample.json
  
  mkdir Test 
  echo 'sampleTest' > ./Test/sampleTest.swift

  cd ../../../
  touch Project.swift
  echo "import ProjectDescription
import ProjectDescriptionHelpers

let projectName = \"$frameworkName\"
let project = Project(
  name: projectName,
  targets: Project.makeFrameworkTargets(
    name: projectName,
    customInfoPlist: .file(path: \"../\(projectName)/Support/InfoPlist/\(projectName)-Info.plist\"),
    dependencies: [],
    testDependencies: []
  )
)
" > Project.swift

}