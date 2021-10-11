import Foundation
import ReactiveSwift
/*
 This use case demonstrates chaining repo calls sequentially
 */
public class PingPongUseCase: UseCase {
    typealias Output = SignalProducer<Loadable<String>, Never>
    let repo: Repository
    init(repo: Repository) {
        self.repo = repo
    }
    func execute() -> SignalProducer<Loadable<String>, Never> {
        return repo.ping() // Make first API call
            // Make the second API call
            .flatMap(.latest) { (response) -> SignalProducer<PingPongDingDong, Error> in
                self.repo.pong()
                    .map { nextResponse in
                        PingPongDingDong(value: "\(response.value) > \(nextResponse.value)")
                    }
            }
            .map { (response) -> Loadable<String> in
                Loadable.Success(data: response.value)
            }
            .flatMapError{ error in
                SignalProducer<Loadable<String>, Never>(value: Loadable.Error(error: error))
            }
            .prefix(value: Loadable.Loading) // Always start with the loading signal
    }
}
