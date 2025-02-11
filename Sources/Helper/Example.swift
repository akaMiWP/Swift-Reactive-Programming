// 
import Foundation

public enum Level {
    case root, one, two, three, four
    
    var prefix: String {
        switch self {
        case .root: "\n\n--- Example of:"
        case .one: "\n>> Sub Example:"
        case .two: ">>>> Sub Example:"
        case .three: ">>>>>> Sub Example"
        case .four: ">>>>>>>> Sub Example"
        }
    }
}

public func example(of description: String, level: Level = .root, action: () -> Void) {
    print(level.prefix, description)
    action()
}
