//
//  FirestoreManager.swift
//  MaDang
//
//  Created by LDW on 8/21/24.
//

import Foundation
import FirebaseFirestore

final class FirestoreManager: ObservableObject {
    @Published var reviews: [Review] = []

    private var db = Firestore.firestore()

    static let shared = FirestoreManager()
    private init() {}

    // MARK: - 리뷰 등록
    func addReview(performanceId: String, writerId: String, writerCountry: Country, writerName: String, content: String, starRating: Double) {
        let newReview = Review(
            performanceId: performanceId,
            writerId: writerId,
            writerCountry: writerCountry,
            writerName: writerName,
            createdDate: Date(),
            content: content,
            likeCount: 0,
            starRating: starRating,
            isReported: false
        )

        do {
            let _ = try db.collection("reviews").addDocument(from: newReview)
        } catch {
            print("Error adding review: \(error)")
        }
    }

    // MARK: - 좋아요 수로 정렬된 리뷰 요청
    func fetchReviewsOrderedByLikes(completion: @escaping ([Review]) -> Void) {
        db.collection("reviews")
            .order(by: "likeCount", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    completion([])
                    return
                }
                
                let reviews = documents.compactMap { docSnapshot -> Review? in
                    return try? docSnapshot.data(as: Review.self)
                }
                
                DispatchQueue.main.async {
                    self.reviews = reviews
                    completion(reviews)
                }
            }
    }
    
    // MARK: 특정 유저 ID 리뷰 요청
    func fetchReviewsByUser(writerId: String, completion: @escaping ([Review]) -> Void) {
        db.collection("reviews")
            .whereField("writerId", isEqualTo: writerId)
            .order(by: "createdDate", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    completion([])
                    return
                }
                
                let reviews = documents.compactMap { docSnapshot -> Review? in
                    return try? docSnapshot.data(as: Review.self)
                }
                
                DispatchQueue.main.async {
                    self.reviews = reviews
                    completion(reviews)
                }
            }
    }
    
    // MARK: - 특정 공연 ID 리뷰 요청
    func fetchReviewsByPerformance(performanceId: String, completion: @escaping ([Review]) -> Void) {
        db.collection("reviews")
            .whereField("performanceId", isEqualTo: performanceId)
            .order(by: "createdDate", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    completion([])
                    return
                }
                
                let reviews = documents.compactMap { docSnapshot -> Review? in
                    return try? docSnapshot.data(as: Review.self)
                }
                
                DispatchQueue.main.async {
                    self.reviews = reviews
                    completion(reviews)
                }
            }
    }
}
