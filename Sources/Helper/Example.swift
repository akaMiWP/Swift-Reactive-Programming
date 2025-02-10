// 
import Foundation

public func example(of description: String, action: () -> Void) {
  print("\n--- Example of:", description, "---")
  action()
}

public func subExample(of description: String, action: () -> Void) {
    print(">>> Sub Example:", description)
    action()
}
