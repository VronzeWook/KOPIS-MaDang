import SwiftUI

struct FAQView: View {
    let faqs: [FAQ] = [
        FAQ(question: "How do I reset my password?", answer: "To reset your password, go to the Settings page, select 'Account', and then choose 'Reset Password'."),
        FAQ(question: "How can I contact support?", answer: "You can contact support by emailing us at support@example.com or using the in-app chat feature."),
        FAQ(question: "Where can I view my order history?", answer: "Your order history can be viewed under the 'Orders' section in your profile."),
        FAQ(question: "How do I update my payment information?", answer: "To update your payment information, go to the 'Payment' section in Settings."),
        FAQ(question: "What is the return policy?", answer: "You can return items within 30 days of purchase. Please refer to our return policy page for more details.")
    ]
    
    init() {
         // Customize the appearance of the navigation bar title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.NineYellow]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.NineYellow]
     }
    
    var body: some View {
        NavigationView {
            List(faqs) { faq in
                DisclosureGroup(faq.question) {
                    Text(faq.answer)
                        .foregroundColor(.white)
                        .padding(.top, 4)
                }
                .padding(.vertical, 8)
                .listRowBackground(Color.black) // Set row background color to black
            }
            .navigationTitle("FAQ")
            .foregroundColor(.white)
            .listStyle(.plain)
            .background(Color.black) // Set list background color to black
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

#Preview {
    FAQView()
}
