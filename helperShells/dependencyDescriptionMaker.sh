function setDependenciesDefault() {
  touch Dependencies.swift
  echo '
  import ProjectDescription

  let dependencies = Dependencies(
    carthage: CarthageDependencies([]),
    swiftPackageManager: SwiftPackageManagerDependencies([
      .remote(url: "https://github.com/Quick/Quick.git", requirement: .branch("master")),
      .remote(url: "https://github.com/Quick/Nimble.git", requirement: .branch("main"))
    ], productTypes: [
      "Quick": .framework,
      "Nimble": .framework
    ])
  )
  ' > Dependencies.swift
}
