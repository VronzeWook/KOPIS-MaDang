//
//  ByGenreModalView.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//

import SwiftUI

struct ByGenreModalView: View {
    @Binding var showModal: Bool
    @Binding var selectedGenre: Genre
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Genre")
                .font(.title3)
                .foregroundStyle(.nineYellow)
                .padding(.top, 20)
                .padding(.bottom, 6)
            Text("Please select the genre you want.")
                .font(.callout)
                .foregroundStyle(.gray)
            
            ForEach(Genre.allCases, id: \.self) { genre in
                Divider()
                    .background(Color.gray)
                    .padding(.vertical, 16)
                
                Button(action: {
                    withAnimation {
                        selectedGenre = genre
                        showModal.toggle()
                    }
                }, label: {
                    VStack {
                        Text("\(genre.rawValue)")
                            .font(.callout)
                            .foregroundStyle(.white)
                    }
                })
            }
        }
        .padding(.bottom, 16)
        .background(.nineDarkGray)
        .cornerRadius(15)
        .padding(.horizontal, 44)
        .shadow(radius: 20)
    }
}

#Preview {
    ByGenreModalView(showModal: .constant(true), selectedGenre: .constant(.All))
}
