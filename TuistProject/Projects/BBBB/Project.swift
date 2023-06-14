import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "BBBB"
let project = Project.makeModule(
  name: projectName,
  product: .app,
  additionalTargets: [],
  isIncludeOnly: true
)

