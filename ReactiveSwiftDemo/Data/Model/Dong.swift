import Foundation
struct Dong: Codable {
    var dong: String
    enum CodingKeys: String, CodingKey {
        case dong
    }
}
extension Dong {
    func toPingPongDingDong() -> PingPongDingDong {
        return PingPongDingDong(value: self.dong)
    }
}
