import Foundation

extension Date {
    var diffDaysFromToday: Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day],
                                                 from: calendar.startOfDay(for: Date()),
                                                 to: calendar.startOfDay(for: self))
        return components.day
    }
}
