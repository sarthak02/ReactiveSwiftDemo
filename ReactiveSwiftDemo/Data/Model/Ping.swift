import Foundation
struct Ping: Codable {
    var ping: String
    enum CodingKeys: String, CodingKey {
        case ping
    }
}
extension Ping {
    func toPingPongDingDong() -> PingPongDingDong {
        return PingPongDingDong(value: self.ping)
    }
}
