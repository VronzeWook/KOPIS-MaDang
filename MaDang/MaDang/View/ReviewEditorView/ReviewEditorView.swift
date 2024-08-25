import SwiftUI
import FirebaseAuth

struct ReviewEditorView: View {
    @FocusState private var isFocused: Bool
    @State private var text: String = ""
    @State private var rating: Double = 0
    @Binding var perform: Performance
    
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode
    
    var writerId: String {
           return Auth.auth().currentUser?.uid ?? "Unknown UserID"
       }
    
    var writerCountry: Country {
        return userManager.user?.country ?? .ALL
    }
    
    var writerName: String {
        return userManager.user?.name ?? "Unknown UserName"
    }
    
    init(perform: Binding<Performance>) {
           self._perform = perform

           UITabBar.appearance().backgroundColor = UIColor.nineBlack
        UITabBar.appearance().barTintColor = UIColor.nineBlack
       }

    
    var body: some View {

            GeometryReader { geo in
                
                let width = geo.size.width * 0.3
                let height = geo.size.height * 0.1
                
                VStack {
                    HStack {
                        AsyncImage(url: URL(string: perform.posterUrlList[0])) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                        } placeholder: {
                            Color.gray
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("What are your thoughts\non the performance?")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                    .padding(.leading, 16)
                                
                                Spacer()
                            }
                            // 별점
                            HStack{
                                RatingView($rating, maxRating: 5)
                                    .frame(width: 140, height: 24)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 16)
                                
                                Text(String(format: "%.1f", rating))
                                    .frame(width: 50, height: height)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                    .font(.system(size: 24))
                                    .padding(.trailing, 24)
                            }
                        }
                    }
                    .padding(.bottom, 24)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.nineDarkGray)
                            .frame(height: UIScreen.main.bounds.height / 2)
                        
                        FocusableTextEditor(text: $text, placeholder: "Tell us your opinion!")
                            .padding(.top, 14)
                            .padding(.leading, 24)
                            .frame(height: UIScreen.main.bounds.height / 2)
                        
                        // .frame(height: geo.size.height * 0.5)
                        
                    }
                    .onTapGesture {
                        isFocused = true
                    }
                    
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .background(.nineBlack)
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = false
                }
                .navigationTitle("Write Review")
                .navigationBarItems(trailing: Button("Save") {
                    
                    // 포스터 url 저장
                    var url = ""
                    
                    if !perform.posterUrlList.isEmpty {
                        url = perform.posterUrlList[0]
                    }
                    
                    // Firestore에 리뷰 저장
                    FirestoreManager.shared.addReview(
                        performanceId: perform.id,
                        performanceTitle: perform.title,
                        posterUrl: url,
                        writerId: writerId,
                        writerCountry: writerCountry,
                        writerName: writerName,
                        content: text,
                        starRating: rating
                    ) { result in
                        switch result {
                        case .success(let reviewId):
                            print("Review added successfully")
                            
                            // 유저의 reviewIdList에 추가
                            guard var user = userManager.user else { return }
                            user.reviewIdList.append(reviewId)
                            
                            // Firestore에 업데이트된 유저 정보 저장
                            FirestoreManager.shared.updateUser(user) { updateResult in
                                switch updateResult {
                                case .success():
                                    // userManager에 반영
                                    userManager.user = user
                                    print("User's reviewIdList updated successfully in Firestore")
                                case .failure(let error):
                                    print("Failed to update user's reviewIdList in Firestore: \(error.localizedDescription)")
                                }
                            }
                            
                            presentationMode.wrappedValue.dismiss()
                        case .failure(let error):
                            print("Failed to add review: \(error.localizedDescription)")
                        }
                    }
                    
                    
                    
                })
            }
    }
}

#Preview {
    ReviewEditorView(perform: .constant(Performance.performList[0]))
}

