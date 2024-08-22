//
//  MyReviewView.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//


import SwiftUI

struct MyReviewView: View {
    let user: User

    var body: some View {
        ScrollView {
            VStack {
//                ForEach(user.reviews) { review in
//                    MyReviewRow(review: review, performances: Performance.performList)
//                        .padding(.vertical, 4)
//                        .background(Color.black) 
//                        .cornerRadius(10)
//                }
            }
            .padding()
        }
        .background(Color.nineBlack)
        .navigationTitle("My Reviews")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    MyReviewView(user: currentUser)
//}

