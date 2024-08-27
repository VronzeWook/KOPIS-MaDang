import SwiftUI

struct ReportModalView: View {
    @Binding var showModal: Bool
    @State private var selectedReason: ReportReason?
    @State private var reasons: [ReportReason] = ReportReason.allCases
    @EnvironmentObject var reportManager: ReportManager
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Report Review")
                .font(.title3)
                .foregroundStyle(.nineYellow)
                .padding(.top, 20)
                .padding(.bottom, 6)
            Text(
            "The review process may take up to 24 hours to complete after reporting."
            )
            .font(.callout)
            .foregroundStyle(.gray)
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
            
            Text("Please select a reason for reporting.")
                .font(.callout)
                .foregroundStyle(.gray)
                .padding(.bottom, 20)
            
            ForEach(reasons, id: \.self) { reason in
                Divider()
                    .background(Color.gray)
                    .padding(.vertical, 8)
                
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedReason = reason
                        }
                    }, label: {
                        HStack {
                            Image(systemName: selectedReason == reason ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(selectedReason == reason ? .nineYellow : .gray)
                                .padding(.trailing, 8)
                            
                            Text(reason.rawValue)
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                    })
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            Divider()
                .background(Color.gray)
                .padding(.vertical, 8)
            
            Button(action: {
                // 신고 처리 로직 추가
                print("Reported for reason: \(selectedReason?.rawValue ?? "None")")
                guard var review = reportManager.selectedReview else {return}
                review.isReported = true
                
                FirestoreManager.shared.upsertReview(performId: review.performanceId, writerId: review.writerId, review: review) { result in
                    switch result {
                    case .success():
                        print("Reported review save success")
                    case .failure(_):
                        print("Reported revie save failed")
                    }
                }
                
                showModal = false
            }) {
                Text("Report")
                    .bold()
                    .foregroundColor(selectedReason != nil ? Color.nineBlack : .white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedReason != nil ? Color.nineYellow : Color.gray)
                    .cornerRadius(10)
            }
            .disabled(selectedReason == nil)
            .padding(.top, 20)
            .padding(.horizontal)
            
        }
        .padding(.bottom, 16)
        .background(Color.nineDarkGray)
        .cornerRadius(15)
        .padding(.horizontal, 44)
        .shadow(radius: 20)
    }
}

enum ReportReason: String, CaseIterable {
    case inappropriateContent = "Inappropriate Content"
    case spam = "Spam"
    case harassment = "Harassment"
    case other = "Other"
}

//#Preview {
//    ReportModalView(showModal: .constant(true), review: Review)
//}
