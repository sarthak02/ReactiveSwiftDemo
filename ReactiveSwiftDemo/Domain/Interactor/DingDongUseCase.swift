import Foundation
import ReactiveSwift
/*
 Keep the error definitions close to where it will happen.
 */
enum DingDongUseCaseError: Error {
    case someFailure
}
extension DingDongUseCaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .someFailure:
            return NSLocalizedString(
                "Something went wrong!",
                comment: "Unknown error."
            )
        }
    }
}
/*
 This use case demonstrates calling repo in parallel
 */
public class DingDongUseCase: UseCase {
    typealias Output = SignalProducer<Loadable<String>, Never>
    let repo: Repository
    init(repo: Repository) {
        self.repo = repo
    }
    func execute() -> SignalProducer<Loadable<String>, Never> {
        // Fire in parallel
        // Fire both in API calls in parallel
        return SignalProducer<SignalProducer<PingPongDingDong, Error>, Error>([repo.ding(), repo.dong()])
            .flatten(.merge) // Collect all results
            .reduce([PingPongDingDong]()) { responses, nextResponse in
                responses + [nextResponse]
            }
            .flatMap(.latest) { (responses: [PingPongDingDong]) in
                SignalProducer<Loadable<String>, Error>(value: Loadable.Success(data: responses.map { $0.value }.joined(separator: " | ")))
            }
            .flatMapError { error in
                SignalProducer<Loadable<String>, Never>(value: Loadable.Error(error: error))
            }
            .prefix(value: Loadable.Loading)
    }
}

