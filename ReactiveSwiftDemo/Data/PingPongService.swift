import Foundation
import Moya
enum PingPongService {
    case ping, pong,ding, dong
}
// MARK: - TargetType Protocol Implementation
extension PingPongService: TargetType {
    var baseURL: URL { return URL(string: "https://inbound-mail-processor.herokuapp.com")! }
    var path: String {
        switch self {
        case .ping:
            return "/ping"
        case .pong:
            return "/pong"
        case .ding:
            return "/ding"
        case .dong:
            return "/dong"
        }
    }
    var method: Moya.Method {
        switch self {
        case .ping, .pong, .ding, .dong:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .ping, .pong, .ding, .dong:
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .ping, .pong, .ding, .dong:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
