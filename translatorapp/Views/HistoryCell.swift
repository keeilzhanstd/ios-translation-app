//
//  HistoryCell.swift
//  translatorapp
//
//  Created by Bekzhan on 8/7/2021.
//

import SwiftUI
import Marquee

struct HistoryCell: View {
    
    var history: TranslatedItem
    
    @State var originalDuration: Double = 10.0
    @State var targetDuration: Double = 10.0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(.systemGray5))
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 100, idealHeight: 100, maxHeight: 200, alignment: .center)
            .overlay( VStack{
                
                
                    if history.from == "en" {
                        HStack {
                            Image("UK_FLAG")
                                .resizable()
                                .frame(width: 16, height: 10, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 1))
                            Marquee {
                                Text(history.originalText)
                            }
                            .marqueeWhenNotFit(true)
                            .marqueeDuration(originalDuration)
                        }
                    } else {
                        HStack {
                            Image("RU_FLAG")
                                .resizable()
                                .frame(width: 16, height: 10, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 1))
                            Marquee {
                                Text(history.originalText)
                            }
                            .marqueeWhenNotFit(true)
                            .marqueeDuration(originalDuration)
                        }
                    }
                
                Divider()
                
                if let targetRu = history.translatedText.ru {
                    HStack {
                        Image("RU_FLAG")
                            .resizable()
                            .frame(width: 16, height: 10, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 1))
                        Marquee {
                            Text(targetRu)
                        }
                        .marqueeWhenNotFit(true)
                        .marqueeDuration(targetDuration)
                    }
                }
                if let targetEn = history.translatedText.en {
                    HStack {
                        Image("UK_FLAG")
                            .resizable()
                            .frame(width: 16, height: 10, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 1))
                        Marquee {
                            Text(targetEn)
                        }
                        .marqueeWhenNotFit(true)
                        .marqueeDuration(targetDuration)
                    }
                    
                }
                
            }
            .padding())
            .onAppear {
                originalDuration = Double(self.history.originalText.count / 3)
                if let ru = self.history.translatedText.ru {
                    self.targetDuration = Double(ru.count / 3)
                }
                if let en = self.history.translatedText.en {
                    self.targetDuration = Double(en.count / 3)
                }
                
            }
    }
    
}

