//
//  ByGenreView.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//

import SwiftUI

struct ByGenreView: View {
    @State private var currentGenre: Genre = .All
    @State private var isModalPresented: Bool = false
    

    var body: some View {
        ZStack {
            ScrollView {
                ByGenreHeader(currentGenre: $currentGenre, isModalPresented: $isModalPresented)
            }
            .background(.nineBlack)

            if isModalPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isModalPresented.toggle()
                        }
                    }
                
                ByGenreModalView(showModal: $isModalPresented, selectedGenre: $currentGenre)
                    .transition(.scale) // Smooth transition
                    .animation(.easeInOut, value: isModalPresented)
            }
        }
    }
}

#Preview {
    ByGenreView()
}
