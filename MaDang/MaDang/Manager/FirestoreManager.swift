import Foundation
import FirebaseFirestore
import FirebaseAuth

final class FirestoreManager: ObservableObject {
    @Published var reviews: [Review] = []

    private var db = Firestore.firestore()
    static let shared = FirestoreManager()
    private init() {}

    // MARK: - 리뷰 등록
    func addReview(performanceId: String,  performanceTitle: String, posterUrl: String, writerId: String, writerCountry: Country, writerName: String, content: String, starRating: Double, completion: @escaping (Result<String, Error>) -> Void) {
        let newReview = Review(
            performanceId: performanceId,
            performanceTitle: performanceTitle,
            posterUrl: posterUrl,
            writerId: writerId,
            writerCountry: writerCountry,
            writerName: writerName,
            createdDate: Date(),
            content: content,
            likeCount: 0,
            starRating: starRating,
            isReported: false
        )

        let documentRef = db.collection("reviews").document()

        do {
            try documentRef.setData(from: newReview) { error in
                if let error = error {
                    print("Error adding review: \(error)")
                    completion(.failure(error))
                    return
                }
                // 문서 ID 반환
                completion(.success(documentRef.documentID))
            }
        } catch {
            print("Error adding review: \(error)")
            completion(.failure(error))
        }
    }

    
    
    // MARK: - 리뷰 업데이트 또는 생성 (업서트)
    func upsertReview(performId: String, writerId: String, review: Review, completion: @escaping (Result<Void, Error>) -> Void) {
        let query = db.collection("reviews")
            .whereField("performanceId", isEqualTo: performId)
            .whereField("writerId", isEqualTo: writerId)
        
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error querying review: \(error)")
                completion(.failure(error))
                return
            }
            
            if let document = snapshot?.documents.first {
                // 문서가 존재하면 덮어씌우기
                do {
                    try document.reference.setData(from: review, merge: true) { error in
                        if let error = error {
                            print("Error updating review: \(error)")
                            completion(.failure(error))
                        } else {
                            print("Review updated successfully")
                            completion(.success(()))
                        }
                    }
                } catch {
                    print("Error encoding review: \(error)")
                    completion(.failure(error))
                }
            } else {
                // 문서가 없으면 새로 생성하기
                do {
                    let _ = try self.db.collection("reviews").addDocument(from: review) { error in
                        if let error = error {
                            print("Error creating review: \(error)")
                            completion(.failure(error))
                        } else {
                            print("Review created successfully")
                            completion(.success(()))
                        }
                    }
                } catch {
                    print("Error encoding review: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }
    
    // MARK: - User 업데이트 메서드
    func updateUser(_ user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = user.id else {
            print("Error: User ID is nil")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID is nil"])))
            return
        }
        
        let userRef = db.collection("users").document(userId)
        
        do {
            try userRef.setData(from: user, merge: true) { error in
                if let error = error {
                    print("Error updating user: \(error)")
                    completion(.failure(error))
                } else {
                    print("User updated successfully")
                    completion(.success(()))
                }
            }
        } catch {
            print("Error encoding user: \(error)")
            completion(.failure(error))
        }
    }
    
    // MARK: - Performance 업데이트 또는 생성 (업서트)
      func upsertPerformance(performance: Performance, completion: @escaping (Result<Void, Error>) -> Void) {
          let performanceRef = db.collection("performances").document(performance.id)

          performanceRef.getDocument { document, error in
              if let error = error {
                  print("Error fetching performance: \(error)")
                  completion(.failure(error))
                  return
              }

              if document?.exists == true {
                  // 문서가 존재하면 덮어씌우기 (업데이트)
                  do {
                      try performanceRef.setData(from: performance, merge: true) { error in
                          if let error = error {
                              print("Error updating performance: \(error)")
                              completion(.failure(error))
                          } else {
                              print("Performance updated successfully")
                              completion(.success(()))
                          }
                      }
                  } catch {
                      print("Error encoding performance: \(error)")
                      completion(.failure(error))
                  }
              } else {
                  // 문서가 없으면 새로 생성하기
                  do {
                      try performanceRef.setData(from: performance) { error in
                          if let error = error {
                              print("Error creating performance: \(error)")
                              completion(.failure(error))
                          } else {
                              print("Performance created successfully")
                              completion(.success(()))
                          }
                      }
                  } catch {
                      print("Error encoding performance: \(error)")
                      completion(.failure(error))
                  }
              }
          }
      }
    
    
    func fetchAllPerformanceIds(completion: @escaping (Result<[String], Error>) -> Void) {
        let performanceRef = db.collection("performances")
        
        performanceRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching performance IDs: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No performances found")
                completion(.success([]))
                return
            }
            
            let performanceIds = documents.compactMap { $0.documentID }
            completion(.success(performanceIds))
        }
    }
    
    func fetchReviewsOrderedByLikes(limit: Int = 20 , completion: @escaping (Result<[Review], Error>) -> Void) {
        db.collection("reviews")
            .order(by: "likeCount", descending: true)
            .limit(to: limit)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching reviews: \(error)")
                    completion(.failure(error))
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No documents")
                    completion(.success([]))
                    return
                }

                let reviews = documents.compactMap { docSnapshot -> Review? in
                    return try? docSnapshot.data(as: Review.self)
                }

                DispatchQueue.main.async {
                    self.reviews = reviews
                    completion(.success(reviews))
                }
            }
    }
    
    // MARK: 특정 유저 ID 리뷰 요청
    func fetchReviewsByUser(writerId: String, completion: @escaping (Result<[Review], Error>) -> Void) {
        db.collection("reviews")
            .whereField("writerId", isEqualTo: writerId)
           // .order(by: "createdDate", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching reviews: \(error)")
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    completion(.success([]))
                    return
                }
                
                let reviews = documents.compactMap { docSnapshot -> Review? in
                    return try? docSnapshot.data(as: Review.self)
                }
                
                DispatchQueue.main.async {
                    self.reviews = reviews
                    completion(.success(reviews))
                }
            }
    }
    
    func fetchReviewsByPerformance(performanceId: String, completion: @escaping (Result<[Review], Error>) -> Void) {
        db.collection("reviews")
            .whereField("performanceId", isEqualTo: performanceId)
            .order(by: "createdDate", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching reviews: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No documents found for performance ID: \(performanceId)")
                    completion(.success([]))
                    return
                }
                
                let reviews = documents.compactMap { docSnapshot -> Review? in
                    do {
                        return try docSnapshot.data(as: Review.self)
                    } catch {
                        print("Error decoding Review: \(error.localizedDescription)")
                        return nil
                    }
                }
                
                DispatchQueue.main.async {
                    self.reviews = reviews
                    completion(.success(reviews))
                }
            }
    }
    
    // MARK: - User 정보 요청 메서드
        func fetchUserById(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
            let userRef = db.collection("users").document(userId)
            
            userRef.getDocument { document, error in
                if let error = error {
                    print("Error fetching user: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                
                guard let document = document, document.exists else {
                    print("No user found with the given ID")
                    completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user found with the given ID"])))
                    return
                }
                
                do {
                    let user = try document.data(as: User.self)
                    completion(.success(user))
                } catch {
                    print("Error decoding user data: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }

    // MARK: - Performance 요청 메서드
    func fetchPerformanceById(performanceId: String, completion: @escaping (Result<Performance, Error>) -> Void) {
        let performanceRef = db.collection("performances").document(performanceId)
        
        performanceRef.getDocument { document, error in
            if let error = error {
                print("Error fetching performance: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists else {
                print("No performance found with the given ID")
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No performance found with the given ID"])))
                return
            }
            
            do {
                let performance = try document.data(as: Performance.self)
                completion(.success(performance))
            } catch {
                print("Error decoding performance data: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - User 생성 메서드
       func createUser(_ user: User, completion: @escaping (Result<Void, Error>) -> Void) {
           guard let userId = user.id else {
               completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID is nil"])))
               return
           }
           
           do {
               try db.collection("users").document(userId).setData(from: user) { error in
                   if let error = error {
                       print("Error creating user: \(error.localizedDescription)")
                       completion(.failure(error))
                   } else {
                       print("User created successfully")
                       completion(.success(()))
                   }
               }
           } catch {
               print("Error encoding user: \(error.localizedDescription)")
               completion(.failure(error))
           }
       }
    
    // MARK: - User 삭제 메서드
     func deleteUser(userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
         db.collection("users").document(userId).delete { error in
             if let error = error {
                 print("Error deleting user: \(error.localizedDescription)")
                 completion(.failure(error))
             } else {
                 print("User deleted successfully from Firestore")
                 completion(.success(()))
             }
         }
     }
    
    // MARK: - 리뷰 삭제 메서드
    func deleteReview(reviewId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let reviewRef = db.collection("reviews").document(reviewId)
        
        reviewRef.delete { error in
            if let error = error {
                print("Error deleting review: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Review deleted successfully")
                completion(.success(()))
            }
        }
    }
}
