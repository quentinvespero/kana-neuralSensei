import Foundation

struct KanaCharacter: Identifiable, Equatable {
    let id = UUID()
    let kana: String
    let romaji: String
    let type: KanaType
    
    // Implement Equatable
    static func == (lhs: KanaCharacter, rhs: KanaCharacter) -> Bool {
        lhs.kana == rhs.kana && lhs.romaji == rhs.romaji && lhs.type == rhs.type
    }
}

enum KanaType: Equatable {
    case hiragana
    case katakana
} 