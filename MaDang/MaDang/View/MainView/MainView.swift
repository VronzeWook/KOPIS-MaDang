import SwiftUI
import FirebaseAuth

struct MainView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var currentGenre: Genre = .All
    @State private var isModalPresented: Bool = false
    @State private var isLangModalPresented: Bool = false
    @State private var currentLang: Language = .Korean
    @Binding var performs: [Performance]
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
//                        MainHeader(currentLang: $currentLang, isLangModalPresented: $isLangModalPresented)
                        
                        WhatIsNewView(performs: $performs)
                            .padding(.bottom, 8)
                        
                        PopularityRankingView(selectedTab: $selectedTab, performs: $performs)
                            .padding(.top, 16)
                        //.border(.nineYellow)
                        
                        GenreView(isModalPresented: $isModalPresented, currentGenre: $currentGenre, performs: $performs)
                        
                        BestReviewView()
                            .padding(.top, 64)
                        
                    }
                    //.border(.green)
                    .background(.nineBlack)
                }
                .background(.black)
                
                
                if isLangModalPresented {
//                    Color.clear
//                        .edgesIgnoringSafeArea(.all)
//                        .onTapGesture {
//                            isLangModalPresented.toggle()
//                        }
//                    
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isLangModalPresented.toggle()
                            }
                        }
                    
                    LangModalView(showModal: $isLangModalPresented, selectedLang: $currentLang)
                        //.background(.nineBlack)
                        .transition(.scale) // Smooth transition
                        .animation(.easeInOut, value: isLangModalPresented)
                }
                
                if isModalPresented {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isModalPresented.toggle()
                            }
                        }
                    
                    GenreModalView(showModal: $isModalPresented, selectedGenre: $currentGenre)
                        .transition(.scale) // Smooth transition
                        .animation(.easeInOut, value: isModalPresented)
                }
            }
        }

    }
}

#Preview {
    MainView(performs: .constant(Performance.performList), selectedTab: .constant(1))
        .environmentObject(UserManager())
}
