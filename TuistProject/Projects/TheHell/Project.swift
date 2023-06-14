import ProjectDescription
  import ProjectDescriptionHelpers

  let projectName = "TheHell"
  let project = Project.makeModule(
    name: projectName,
    platform: .iOS,
    product: .app,
    dependencies: [],
    bridgingHeaderPath: "Support/BridgingHeader/TheHell-Bridging-Header.h",
    customInfoPlist: .file(path: "Support/InfoPlist/Info.plist"),
    additionalTargets: []
  )
