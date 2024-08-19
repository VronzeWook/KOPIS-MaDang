//
//  AccountProfile.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//

import SwiftUI

struct AccountProfile: View {
    
    var body: some View {
        VStack {
            HStack {
                Image("logo")
                Spacer()
            }
            .padding(.bottom, 5)
            
            HStack {
                Text("Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Spacer()
            }
            ProfileView()
            
        }
        .background(.nineBlack)
        .padding(.horizontal, 16)
    }
}

#Preview {
    AccountProfile()
}


struct ProfileView : View {
    
    @State private var showingImagePicker = false
    @State private var profileImage: Image? = Image("profile")
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Button(action: {
                    showingImagePicker = true
                }) {
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                        Text("Edit")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding(.top,24)
            .padding(.horizontal, 22)
            
            VStack{
                profileImage?
                    .resizable()
                    .frame(width: 82, height: 82)
                    .scaledToFit()
                    .cornerRadius(90)
                HStack{
                    Text("Ashley")
                        .font(.system(size: 26))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("🇺🇸")
                        .font(.system(size: 26))
                }
            }
            Divider()
                .background(Color.gray)
                .padding(.vertical,4)
            
            HStack{
                VStack{
                    HStack{
                        Image(systemName: "heart.fill")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundStyle(.nineYellow)
                        Text("24")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundStyle(.nineYellow)
                    }.padding(.bottom,2)
                    Text("Likes")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                }
                
                VStack{
                    HStack{
                        Image(systemName: "text.bubble.fill")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundStyle(.nineYellow)
                        Text("18")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundStyle(.nineYellow)
                    }.padding(.bottom,2)
                    Text("Reviews")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                }.padding(.horizontal,25)
                VStack{
                    HStack{
                        Image(systemName: "hand.thumbsup.fill")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundStyle(.nineYellow)
                        Text("231")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundStyle(.nineYellow)
                    }.padding(.bottom,2)
                    Text("Empathy")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
            .padding(.vertical,24)
        }
        .background(.nineDarkGray)
        .cornerRadius(15)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
    }
}
