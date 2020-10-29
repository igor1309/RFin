import Foundation

struct Ratio: Hashable {
    var markup: Double
    
    var margin: Double {
        get { 1 - 1/(markup + 1) }
        set { markup = newValue < 1 ? 1/(1 - newValue) - 1 : 0 }
    }
    
    init(markup: Double) {
        self.markup = markup
    }
    
    init?(margin: Double) {
        guard margin > 0 && margin < 1 else {
            return nil
        }
        self.init(markup: 10/100)
        self.margin = margin
    }
}

if let r1 = Ratio(margin: 75/100) {
    print(r1.markup)
}
if let r2 = Ratio(margin: 50/100) {
    print(r2.markup)
}

let values: [Double] = [20, 25, 33, 50, 75, 80].map { $0/100 }
let values1 = values.filter { $0 < 1 }
