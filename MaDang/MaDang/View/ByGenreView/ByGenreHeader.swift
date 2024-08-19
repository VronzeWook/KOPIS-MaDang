//
//  ByGenreHeader.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//


import SwiftUI

struct ByGenreHeader: View {
    @Binding var currentGenre: Genre
    @Binding var isModalPresented: Bool

    var body: some View {
        VStack {
            HStack {
                Image("logo")
                Spacer()
            }
            .padding(.bottom, 5)

            HStack {
                Text("Genre")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Spacer()
                
                Button {
                    withAnimation {
                        isModalPresented.toggle()
                    }
                } label: {
                    HStack {
                        Text("\(currentGenre.rawValue)")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.nineYellow)
                            .padding(.vertical, 8)
                        
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.nineYellow)
                    }
                    .padding(.horizontal, 18)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18.5)
                            .foregroundStyle(.nineYellow.opacity(0.2))
                    )
                }
            }
        }
        .background(.nineBlack)
        .padding(.horizontal, 16)
    }
}

#Preview {
    ByGenreHeader(currentGenre: .constant(.All), isModalPresented: .constant(false))
}

