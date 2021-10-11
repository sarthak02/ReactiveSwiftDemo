import Foundation
import ReactiveSwift
import Moya
class RepositoryImpl: Repository {
    let provider: MoyaProvider<PingPongService>
    init(provider: MoyaProvider<PingPongService>) {
        self.provider = provider
    }
    func ping() -> SignalProducer<PingPongDingDong, Error> {
        return provider.reactive.request(.ping)
            .mapError{ moyaError in
                RepositorError.unknownError
            }
            .attemptMap { response -> Result<PingPongDingDong, Error> in
                do {
                    return try Result<PingPongDingDong, Error>.success(response.map(Ping.self).toPingPongDingDong())
                } catch let error {
                    return Result<PingPongDingDong, Error>.failure(error)
                }
            }
    }
    func pong() -> SignalProducer<PingPongDingDong, Error>{
        return provider.reactive.request(.pong)
            .mapError{ moyaError in
                RepositorError.unknownError
            }
            .attemptMap { response -> Result<PingPongDingDong, Error> in
                do {
                    return try Result<PingPongDingDong, Error>.success(response.map(Pong.self).toPingPongDingDong())
                } catch let error {
                    return Result<PingPongDingDong, Error>.failure(error)
                }
            }
    }
    func ding() -> SignalProducer<PingPongDingDong, Error> {
        return provider.reactive.request(.ding)
            .mapError{ moyaError in
                RepositorError.unknownError
            }
            .attemptMap { response -> Result<PingPongDingDong, Error> in
                do {
                    return try Result<PingPongDingDong, Error>.success(response.map(Ding.self).toPingPongDingDong())
                } catch let error {
                    return Result<PingPongDingDong, Error>.failure(error)
                }
            }
    }
    func dong() -> SignalProducer<PingPongDingDong, Error>{
        return provider.reactive.request(.dong)
            .mapError{ moyaError in
                RepositorError.unknownError
            }
            .attemptMap { response -> Result<PingPongDingDong, Error> in
                do {
                    return try Result<PingPongDingDong, Error>.success(response.map(Dong.self).toPingPongDingDong())
                } catch let error {
                    return Result<PingPongDingDong, Error>.failure(error)
                }
            }
    }
}
