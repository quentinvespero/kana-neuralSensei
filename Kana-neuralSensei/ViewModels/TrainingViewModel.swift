import SwiftUI

@Observable
class TrainingViewModel {
    private(set) var originalPhrase: String = ""
    private(set) var correctTranslation: String = ""
    private(set) var isLoading = false
    private(set) var feedback: String = ""
    
    var japaneseFormat: JapaneseFormat = .normal
    var translationDirection: TranslationDirection = .japaneseToOther
    var difficulty: Difficulty = .beginner
    var userTranslation: String = ""
    
    func clearFeedback() {
        feedback = ""
    }
    
    func generateNewPhrase() async {
        isLoading = true
        // TODO: Implement actual API call
        // This is a placeholder
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        switch (translationDirection, japaneseFormat) {
        case (.japaneseToOther, .romaji):
            originalPhrase = "ohayou gozaimasu"
            correctTranslation = "Good morning"
        case (.japaneseToOther, .kanaOnly):
            originalPhrase = "おはよう ございます"
            correctTranslation = "Good morning"
        case (.japaneseToOther, .normal):
            originalPhrase = "おはようございます"
            correctTranslation = "Good morning"
        case (.otherToJapanese, _):
            originalPhrase = "Good morning"
            correctTranslation = japaneseFormat == .romaji ? "ohayou gozaimasu" :
                               japaneseFormat == .kanaOnly ? "おはよう ございます" :
                               "おはようございます"
        }
        
        isLoading = false
    }
    
    func checkTranslation() async {
        isLoading = true
        // TODO: Implement actual API call for translation verification
        // This is a placeholder
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        if userTranslation.lowercased() == correctTranslation.lowercased() {
            feedback = "Perfect! Your translation is correct."
        } else {
            feedback = "Close! The correct translation would be: \(correctTranslation)"
        }
        
        isLoading = false
    }
} 
