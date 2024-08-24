//
//  GenreModalView.swift
//  MaDang
//
//  Created by LDW on 8/18/24.
//

import SwiftUI

struct GenreModalView: View {
    @Binding var showModal: Bool
    @Binding var selectedGenre: Genre
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Text("Genre")
                    .font(.title3)
                    .foregroundStyle(.nineYellow)
                    .padding(.top, 16)
                Text("Please select the genre you want.")
                    .font(.callout)
                    .foregroundStyle(.gray)
                
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: geometry.size.width * 0.7)
                    .foregroundStyle(.gray)
                    .padding(.top, 16)
                
                ForEach(Genre.allCases, id: \.self) { genre in
                    
                    Button(action: {
                        withAnimation {
                            selectedGenre = genre
                            showModal.toggle()
                        }
                    }, label: {
                        VStack{
                            Text("\(genre.rawValue)")
                                .font(.callout)
                                .foregroundStyle(.white)
                                .cornerRadius(8)
                                .padding(.vertical, 12)
                            
                            Rectangle()
                                .frame(height: 1)
                                .frame(maxWidth: geometry.size.width * 0.7)
                                .foregroundStyle(.gray)
                        }
                    })

                }
            }
            .background(.nineDarkGray)
            .cornerRadius(20)
            .shadow(radius: 10)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
}

#Preview {
    GenreModalView(showModal: .constant(true), selectedGenre: .constant(.All))
}
