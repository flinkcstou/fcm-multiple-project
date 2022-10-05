import Foundation

@objc public class FCMMultipleProject: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
