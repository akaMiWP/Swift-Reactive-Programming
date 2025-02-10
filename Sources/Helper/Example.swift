// 
import Foundation

public enum Level {
    case root, one, two, three, four
    
    var prefix: String {
        switch self {
        case .root: "\n--- Example of:"
        case .one: ">> Sub Example of:"
        case .two: ">>>> Sub Example of:"
        case .three: ">>>>>> Sub Example of:"
        case .four: ">>>>>>>> Sub Example of:"
        }
    }
}

public func example(of description: String, level: Level = .root, action: () -> Void) {
    print(level.prefix, description)
    action()
}
