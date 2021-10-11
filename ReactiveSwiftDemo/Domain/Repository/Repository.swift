import Foundation
import ReactiveSwift
/*
 Keep the error definitions close to where it will happen.
 */
enum RepositorError: Error {
    case unknownError
}
extension RepositorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString(
                "Something went wrong. Please try again!",
                comment: "Unknown error."
            )
        }
    }
}
protocol Repository {
    func ping() -> SignalProducer<PingPongDingDong, Error>
    func pong() -> SignalProducer<PingPongDingDong, Error>
    func ding() -> SignalProducer<PingPongDingDong, Error>
    func dong() -> SignalProducer<PingPongDingDong, Error>
}
