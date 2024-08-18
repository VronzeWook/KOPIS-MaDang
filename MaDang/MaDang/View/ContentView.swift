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
                shared.fetchPerformList(startDate: "20240601", endDate: "20240631", row: 5, genreCode: Genre.Theater.code) { result in
                     switch result {
                     case .success(let performs) :
                         print("success")
                         for perform in performs {
                             print("-----------------------------")
                             print(" perform id :\(perform.id)")
                             print(" perform title :\(perform.title)")
                             print(" perform genre : \(perform.genre)")
                             print(" perform startdate : \(perform.startDate)")
                             print("-----------------------------")
                         }
                         
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
