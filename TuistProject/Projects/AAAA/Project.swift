import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "AAAA"
let project = Project.makeModule(
  name: projectName,
  product: .app,
  additionalTargets: [],
  isIncludeOnly: true
)

