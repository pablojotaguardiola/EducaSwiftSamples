import SwiftUI

@Observable
class MyViewModel {
    
    func getSquare(number: Int) -> Int {
        number * number
    }
}
