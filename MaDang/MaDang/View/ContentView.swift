//
//  ContentView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

struct ContentView: View {
    
    let shared = KopisNetworkingManager.shared
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button(action: {
                 shared.fetchPerformList(startDate: "20240601", endDate: "20240631", row: 5, genreCode: "AAAA") { result in
                     switch result {
                     case .success(_) :
                         print("success")
                     case .failure(_):
                         print("failure")
                     }
                 }

            }, label: {
                Text("Button")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
