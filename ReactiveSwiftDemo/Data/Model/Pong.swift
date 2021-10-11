import Foundation
struct Pong: Codable {
    var pong: String
    enum CodingKeys: String, CodingKey {
        case pong
    }
}
extension Pong {
    func toPingPongDingDong() -> PingPongDingDong {
        return PingPongDingDong(value: self.pong)
    }
}
