import SwiftUI
import FirebaseAuth

struct MainView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var currentGenre: Genre = .All
    @State private var isModalPresented: Bool = false
    @State private var isLangModalPresented: Bool = false
    @State private var currentLang: Language = .Korean
    @Binding var performs: [Performance]

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        MainHeader(currentLang: $currentLang, isLangModalPresented: $isLangModalPresented)

                        WhatIsNewView(performs: $performs)
                            .padding(.bottom, 8)

                        PopularityRankingView(performs: $performs)
                            .padding(.top, 16)
                            //.border(.nineYellow)

                        GenreView(currentGenre: $currentGenre, performs: $performs)

                        BestReviewView()
                            .padding(.top, 64)

                    }
                    //.border(.green)
                    .background(.nineBlack)
                }
                .background(.black)
            }

            if isLangModalPresented {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isModalPresented.toggle()
                    }

                LangModalView(showModal: $isLangModalPresented, selectedLang: $currentLang)
                    .background(.nineBlack)
                    .animation(.easeInOut, value: isLangModalPresented)
            }
        }

    }
}

#Preview {
    MainView(performs: .constant(Performance.performList))
        .environmentObject(UserManager())
}
