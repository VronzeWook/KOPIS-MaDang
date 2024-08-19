//
//  FocusableTextEditor.swift
//  MaDang
//
//  Created by LDW on 8/19/24.
//
import SwiftUI

struct FocusableTextEditor: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: FocusableTextEditor

        init(parent: FocusableTextEditor) {
            self.parent = parent
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = ""
                textView.textColor = .white
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = .gray
            } else {
                parent.text = textView.text
            }
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        textView.text = placeholder
        textView.textColor = .gray
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .sentences
        textView.isScrollEnabled = true

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if text.isEmpty && !uiView.isFirstResponder {
            uiView.text = placeholder
            uiView.textColor = .gray
        } else if !text.isEmpty || uiView.isFirstResponder {
            uiView.text = text
            uiView.textColor = .white
        }
    }
}
