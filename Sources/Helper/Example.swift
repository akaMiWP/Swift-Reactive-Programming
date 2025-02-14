// 
import Foundation

public enum Level {
    case root, one, two, three, four
    
    var prefix: String {
        switch self {
        case .root: "\n\n--- Example of:"
        case .one: "\n>> "
        case .two: ">>>> "
        case .three: ">>>>>> "
        case .four: ">>>>>>>> "
        }
    }
}

public func example(of description: String, level: Level = .root, action: () -> Void) {
    print(level.prefix, description)
    action()
}
