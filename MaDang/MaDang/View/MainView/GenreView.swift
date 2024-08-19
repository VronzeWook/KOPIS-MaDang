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
    @Binding var performs: [Performance]
    
    var body: some View {
        
        let filteredPerforms = performs
//            
//            .filter { per in
//            if currentGenre == .All {return true}
//            return per.genre == currentGenre
//              return true
//        }
//        .prefix(9)
        
        
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
                        
                        NavigationLink {
                            DetailView(perform: $performs[performs.firstIndex(where: { $0.id == perform.id })!])
                        } label: {
                            ZStack {
    //                            Image("kopisTestImage")
    //                                .resizable()
    //                                .aspectRatio(contentMode: .fill)
                                
                                let url = perform.posterUrlList.isEmpty ? "" : perform.posterUrlList[0]
                                
                                AsyncImage(url: URL(string: url)) {image in
                                    image
                                        .resizable()
                                        .scaledToFill() // 이미지를 그리드 아이템에 맞게 채우기
                                        //.frame(width: 100, height: 150) // 적절한 크기로 제한
                                        //.clipped()
                                } placeholder: {
                                    ProgressView()
                                        .foregroundStyle(.nineDarkGray)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                .aspectRatio(contentMode: .fit)
                                .clipped()
                                
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0)]),
                                    startPoint: .bottom,
                                    endPoint: .center
                                )
                                .frame(maxWidth: .infinity, alignment: .bottom)
                            }
                        }
                    }
                    .onAppear{
                        print("공연 개수 : \(filteredPerforms.count)")
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
    GenreView(currentGenre: .constant(.All), performs: .constant(Performance.performList))
}
