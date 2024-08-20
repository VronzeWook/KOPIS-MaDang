//
//  ByGenreView.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//
//
import SwiftUI


struct ByGenreView: View {
    @State private var currentGenre: Genre = .All
    @State private var isModalPresented: Bool = false
    @Binding var performs: [Performance]
    

    var body: some View {
        
// 선택된 장르
//        let filteredPerforms = performs.filter { perform in
//            currentGenre == .All || perform.genre == currentGenre
//        }
  
        let filteredPerforms = performs.filter { perform in
                        currentGenre == .All || perform.genre == currentGenre
        }
        let columns = Array(repeating: GridItem(.flexible()), count: 2)
        
        ZStack {
            ScrollView {
                ByGenreHeader(currentGenre: $currentGenre, isModalPresented: $isModalPresented)
                
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(filteredPerforms, id: \.id) { perform in
                        VStack(alignment:.leading){
                            NavigationLink {
                                DetailView(perform: $performs[performs.firstIndex(where: { $0.id == perform.id })!])
                            } label: {
                                ZStack {
                                    
                                    let url = perform.posterUrlList.isEmpty ? "" : perform.posterUrlList[0]
                                    
                                    AsyncImage(url: URL(string: url)) {image in
                                        image
                                            .resizable()
                                            .scaledToFill()
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
                            
                            Text(perform.genre.rawValue)
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                            
                            Text(perform.title)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(.vertical,2)
                            
                            HStack(alignment:.top){
                                Image(systemName: "calendar")
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                
                                Text("\(perform.startDate, formatter: dateFormatter) ~ \(perform.endDate, formatter: dateFormatter)")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            
                            HStack(alignment:.top) {
                                Image(systemName: "shoeprints.fill")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.gray)
                                
                                Text(perform.area)
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.gray)
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
    ByGenreView(performs: .constant(Performance.performList))
}


private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()




