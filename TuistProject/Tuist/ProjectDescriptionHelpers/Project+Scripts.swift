import ProjectDescription

    extension TargetScript {
    
    enum RunOrderType {
        case pre
        case post
    }
    
    static func makeScript(order: RunOrderType, scriptPath: String, name: String) -> TargetScript {
        switch order {
        case .pre:
        return .pre(script: scriptPath, name: name)
        case .post:
        return .post(script: scriptPath, name: name)
        }
    }
    }
