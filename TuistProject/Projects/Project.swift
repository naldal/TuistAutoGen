import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "CCCC"
let project = Project.makeModule(
  name: projectName,
  product: .app,
  additionalTargets: [],
  isIncludeOnly: false
)

