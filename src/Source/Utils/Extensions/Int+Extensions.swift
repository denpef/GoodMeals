import Foundation

extension Int {
    /**
     Represent amount on kg/gr mass unit (>100 gr => 0.1 kg)
     */
    var formattedMass: String {
        let unit = self > 100 ? UnitMass.kilograms : UnitMass.grams
        let amount = self > 100 ? Double(self) / 1000 : Double(self)
        return Measurement(value: amount, unit: unit).description
    }
}
