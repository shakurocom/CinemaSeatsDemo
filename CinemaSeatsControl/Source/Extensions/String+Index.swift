import Foundation

extension String {

    subscript (ind: Int) -> Character {
        return self[index(startIndex, offsetBy: ind)]
    }

}
