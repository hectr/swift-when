import Foundation

extension Date {
    init(intervalSince1970: TimeInterval, addingTimeZone timeZone: TimeZone) {
        let date = Date(timeIntervalSince1970: intervalSince1970)
        self = date.addingTimeInterval(TimeInterval(-timeZone.secondsFromGMT(for: date)))
    }

    init(intervalSinceReferenceDate: TimeInterval, addingTimeZone timeZone: TimeZone) {
        let date = Date(timeIntervalSinceReferenceDate: intervalSinceReferenceDate)
        self = date.addingTimeInterval(TimeInterval(-timeZone.secondsFromGMT(for: date)))
    }
}
