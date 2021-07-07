//
//  HistoryView.swift
//  translatorapp
//
//  Created by Bekzhan on 15/6/2021.
//

import SwiftUI
import Marquee

struct HistoryView: View {
    
    @EnvironmentObject var translateVM: TranslateViewModel
    
    
    var body: some View {
        ScrollView {
            ForEach(translateVM.history, id: \.self) {history in
                HistoryCell(history: history)
            }
        }
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
