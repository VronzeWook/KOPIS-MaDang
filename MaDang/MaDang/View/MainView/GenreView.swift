//
//  GenreView.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct GenreView: View {
    
    @State private var isModalPresented: Bool = false
    @Binding var currentGenre: Genre
    @State private var performs: [Performance] = Performance.performList
    
    var body: some View {
        
        let filteredPerforms = performs.filter { per in
            if currentGenre == .All {return true}
            return per.genre == currentGenre
        }
        .prefix(9)
        
        let columns = Array(repeating: GridItem(.flexible()), count: 3)
        
        ZStack {
            VStack{
                HStack{
                    Text("Genre")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            isModalPresented.toggle()
                        }
                    } label: {
                        HStack{
                            Text("\(currentGenre.rawValue)")
                                .font(.system(size: 16))
                                .foregroundColor(.nineYellow)
                                .padding(.vertical, 8)
                                .padding(.leading, 8)
                                .background(Color.clear)
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.nineYellow)
                                .padding(.trailing, 8)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 18.5)
                                .foregroundStyle(.nineYellow.opacity(0.2))
                        )
                    }
                }
                
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(filteredPerforms, id: \.id) { perform in
                        ZStack {
                            Image("kopisTestImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0)]),
                                startPoint: .bottom,
                                endPoint: .center
                            )
                            .frame(maxWidth: .infinity, alignment: .bottom)
                        }
                    }
                }
                .padding(.top, 20)
  
            }
            .background(.nineBlack)
            .allowsHitTesting(!isModalPresented)
            
            if isModalPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isModalPresented.toggle()
                        }
                    }
                
                GenreModalView(showModal: $isModalPresented, selectedGenre: $currentGenre)
    
            }
        }
    }
}

extension GenreView {
    
    
    
}

#Preview {
    GenreView(currentGenre: .constant(.All))
}
