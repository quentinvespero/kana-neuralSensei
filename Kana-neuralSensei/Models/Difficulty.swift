import Foundation

enum Difficulty: String, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    
    var maxWordCount: Int {
        switch self {
        case .beginner: return 3
        case .intermediate: return 5
        case .advanced: return 8
        }
    }
} 