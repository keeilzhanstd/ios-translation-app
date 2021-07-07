//
//  ContentView.swift
//  translatorapp
//
//  Created by Bekzhan on 15/6/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var translateVM: TranslateViewModel
    
    @State var currentLocal: String = "Type in text"
    @State var currentLang: String = "UK_FLAG"
    @State var targetLang: String = "RU_FLAG"
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray6))
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    HStack(spacing: 32){
                        
                        Image(currentLang)
                            .resizable()
                            .frame(width: 80, height: 50, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                        
                        Button(action: exchangeLanguages, label: {
                            Circle()
                                .fill(Color(.systemBackground))
                                .frame(width: 64, height: 64, alignment: .center)
                                .overlay(
                                    Image(systemName: "arrow.left.arrow.right")
                                        .resizable()
                                        .font(.largeTitle)
                                        .foregroundColor(.primary)
                                        .background(Color(.systemBackground))
                                        .frame(width: 16, height: 16, alignment: .center)
                                )
                        })
                        
                        Image(targetLang)
                            .resizable()
                            .frame(width: 80, height: 50, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(radius: 5)
                        
                    }
                    VStack {
                        
                        VStack(spacing: 16) {
                            TextEditor(text: $currentLocal )
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(color: .gray, radius: 1, x: 1, y: 1)
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemBackground))
                                .overlay(
                                    VStack(alignment: .leading){
                                    Text(translateVM.latest)
                                        .multilineTextAlignment(.leading)
                                        .padding()
                                    Spacer()
                                    }
                                )
                                .shadow(color: .gray, radius: 1, x: 1, y: 1)
                        }
                        .padding()
                        
                        Rectangle()
                            .fill(Color(.systemBackground))
                            .frame(height: 64)
                            .shadow(color: .gray, radius: 1, x: 0, y: 1)
                            
                            .overlay(
                                
                                Button(action: translateAction, label: {
                                    HStack{
                                        Image(systemName: "wand.and.stars")
                                            .resizable()
                                            .font(.largeTitle)
                                            .foregroundColor(.primary)
                                            .background(Color(.systemBackground))
                                            .frame(width: 32, height: 32, alignment: .center)
                                        Text("Translate")
                                            .font(.title2)
                                            .foregroundColor(.primary)
                                            .fontWeight(.semibold)
                                    }
                                })
                                .padding(.horizontal)
                            )
                        
                        NavigationLink(
                            destination: HistoryView(),
                            label: {
                                Capsule()
                                    .fill(Color(.systemBackground))
                                    .padding()
                                    .frame(height: 100)
                                    .shadow(radius: 1)
                                    .overlay(
                                        Text("Translations History")
                                            .foregroundColor(.primary)
                                    )
                            })
                        
                        
                    }
                }
                
            }
            
            .navigationBarHidden(true)
            .navigationBarTitle("iTranslator", displayMode: .inline)
        }
    }
    
    func translateAction() {
        var target = ""
        var origin = ""
        if currentLang == "UK_FLAG" {
            origin = "en"
            target = "ru"
        }
        else
        {
            origin = "ru"
            target = "en"
        }
        
        let httpRespTypeParam = currentLocal.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let rq = TranslationItem(targetString: httpRespTypeParam ?? "Error", targetLang: target, originLang: origin)
        translateVM.postTranslationRequest(item: rq)
        
    }
    
    func exchangeLanguages() {
        var tmp = ""
        tmp = targetLang
        targetLang = currentLang
        currentLang = tmp
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
