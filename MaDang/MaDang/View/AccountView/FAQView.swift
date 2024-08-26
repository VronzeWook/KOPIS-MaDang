import SwiftUI

struct FAQView: View {
    let faqs: [FAQ] = [
        FAQ(question: "How can I contact support?", answer: "You can contact support by emailing us at mg6095@naver.com."),
    ]
    
    init() {
         // Create a custom appearance for the navigation bar
         let appearance = UINavigationBarAppearance()
         appearance.configureWithOpaqueBackground()
         appearance.backgroundColor = UIColor.black // Set the background color to black
         appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Set the title color to white
         appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Set the large title color to white

         // Apply the appearance settings to the navigation bar
         UINavigationBar.appearance().standardAppearance = appearance
         UINavigationBar.appearance().scrollEdgeAppearance = appearance
         UINavigationBar.appearance().compactAppearance = appearance
     }

    
    var body: some View {
        NavigationStack {
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
