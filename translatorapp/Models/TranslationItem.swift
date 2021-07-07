//
//  TranslationItem.swift
//  translatorapp
//
//  Created by Bekzhan on 17/6/2021.
//

import Foundation

struct TranslatedItem: Codable, Hashable{
    let status: Int
    let from, to, originalText: String
    let translatedText: TranslatedText
    let translatedCharacters: Int

    enum CodingKeys: String, CodingKey {
        case status, from, to
        case originalText = "original_text"
        case translatedText = "translated_text"
        case translatedCharacters = "translated_characters"
    }
}


struct TranslationItem: Codable, Hashable {
    let targetString: String
    let targetLang: String
    let originLang: String
}

// MARK: - TranslatedText
struct TranslatedText: Codable, Hashable {
    let ru: String?
    let en: String?
}
