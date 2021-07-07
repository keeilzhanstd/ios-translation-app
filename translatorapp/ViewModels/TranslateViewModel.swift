//
//  TranslateViewModel.swift
//  translatorapp
//
//  Created by Bekzhan on 17/6/2021.
//

import Foundation

class TranslateViewModel: ObservableObject {
    
    @Published var history: [TranslatedItem] = [] {
            didSet {
                saveLatestCoinsData()
            }
        }
    
    @Published var latest: String = ""
    
    init() {
        getHistoryFromUserData()
    }
    
    func getHistoryFromUserData() {
            guard
                let data = UserDefaults.standard.data(forKey: "translationHistory"),
                let gotten = try? JSONDecoder().decode([TranslatedItem].self, from: data)
            else {return}
            
            self.history = gotten
        }
    
    func postTranslationRequest(item: TranslationItem) {
        guard let url = URL(string: "https://nlp-translation.p.rapidapi.com/v1/translate?text=\(item.targetString)&to=\(item.targetLang)&from=\(item.originLang)" ) else {
                print("Invalid URL")
                print("https://nlp-translation.p.rapidapi.com/v1/translate?text=\(item.targetString)&to=\(item.targetLang)&from=\(item.originLang)")
                return
            }
            print("https://nlp-translation.p.rapidapi.com/v1/translate?text=\(item.targetString)&to=\(item.targetLang)&from=\(item.originLang)")
            var request = URLRequest(url: url)
            request.addValue("nlp-translation.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
            request.addValue("45deb4bc11msha713983469ba166p1c2fa8jsn4788f379babe", forHTTPHeaderField: "X-RapidAPI-Key")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(TranslatedItem.self, from: data) {
                        
                        DispatchQueue.main.async {
                            self.history.append(decodedResponse)
                            if item.targetLang == "ru"{
                                self.latest = decodedResponse.translatedText.ru ?? "Error"
                            } else {
                                self.latest = decodedResponse.translatedText.en ?? "Error"
                            }
                            print(self.latest)
                        }
                        
                        return
                    }
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown failure.")")
            }.resume()
        }
        
    func saveLatestCoinsData() {
          if let encoded = try? JSONEncoder().encode(history) {
              UserDefaults.standard.set(encoded, forKey: "translationHistory")
          }
    }
    
}
