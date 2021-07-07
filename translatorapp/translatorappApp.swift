//
//  translatorappApp.swift
//  translatorapp
//
//  Created by Bekzhan on 15/6/2021.
//

import SwiftUI

@main
struct translatorappApp: App {
    @StateObject var translateVM: TranslateViewModel = TranslateViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(translateVM)
        }
    }
}
