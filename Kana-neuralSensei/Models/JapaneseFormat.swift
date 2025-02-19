import Foundation

enum JapaneseFormat: String, CaseIterable {
    case romaji = "Romaji"
    case kanaOnly = "Kana Only"
    case normal = "Normal Japanese"
}

enum TranslationDirection: String, CaseIterable {
    case japaneseToOther = "Japanese → Other"
    case otherToJapanese = "Other → Japanese"
} 