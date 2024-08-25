//
//  MyReviewView.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//


import SwiftUI

struct MyReviewView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var reviews: [Review] = []
    
    var userId: String {
        guard let user = userManager.user else {
            return ""
        }
        return user.id ?? ""
    }
    
    var body: some View {
        VStack{
            if reviews.isEmpty {
                Spacer()
                Text("No Reviews")
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            } else {
                
                ScrollView {
                    VStack {
                        ForEach(reviews) { review in
                            MyReviewRow(review: review)
                                .padding(.vertical, 4)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
        }
        .background(Color.nineBlack)
        .navigationTitle("My Reviews")
        .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    FirestoreManager.shared.fetchReviewsByUser(writerId: userId) { result in
                        switch result {
                        case .success(let reviews):
                            self.reviews = reviews
                        case .failure(_):
                            print("fetch my reviews error")
                        }
                    }
                }
    }
}

#Preview {
    MyReviewView()
}

