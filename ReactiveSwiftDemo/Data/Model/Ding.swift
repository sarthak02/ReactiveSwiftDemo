import Foundation
struct Ding: Codable {
    var ding: String
    enum CodingKeys: String, CodingKey {
        case ding
    }
}
extension Ding {
    func toPingPongDingDong() -> PingPongDingDong {
        return PingPongDingDong(value: self.ding)
    }
}
