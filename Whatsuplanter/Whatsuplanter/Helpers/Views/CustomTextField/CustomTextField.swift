//
//  CustomTextField.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 02.12.2024.
//

import SwiftUI

struct CustomTextField: View {
    var title: String = ""
    var placeholder: String = ""
    var isDynamic = false
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(Fonts.DMSans.medium.swiftUIFont(size: 16))
                .foregroundStyle(.white)
            
            if isDynamic {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .scrollIndicators(.never)
                        .foregroundStyle(.cloudWhite)
                        .font(Fonts.DMSans.regular.swiftUIFont(size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                    
                    
                    if text.isEmpty {
                        createPlaceholder(text: placeholder,
                                          isDynamic: isDynamic)
                    }
                }
                .background(.gray)
                .cornerRadius(8, corners: .allCorners)
                .frame(minHeight: 60)
                
            } else {
                TextField(text: $text) {
                    createPlaceholder(text: placeholder,
                                      isDynamic: isDynamic)
                }
                .font(Fonts.DMSans.regular.swiftUIFont(size: 16))
                .foregroundStyle(.cloudWhite)
                .padding()
                .background(.gray)
                .cornerRadius(8, corners: .allCorners)
            }
        }
        .hideKeyboardWhenTappedAround()
        .padding(.horizontal, 4)
    }
}

private extension CustomTextField {
    func createPlaceholder(text: String, isDynamic: Bool) -> some View {
        return Text(text)
            .font(Fonts.DMSans.italic.swiftUIFont(size: 16))
            .foregroundStyle(.cloudWhite)
            .padding(.horizontal, isDynamic ? 12 : 0)
            .padding(.vertical, isDynamic ? 27 : 0)
            .allowsHitTesting(false)
    }
}

#Preview {
    ZStack {
        Color.gray
        
        ScrollView {
            VStack(spacing: 20) {
                CustomTextField(title: "Title",
                                placeholder: "placeholder",
                                text: .constant("Some text"))
                
                CustomTextField(title: "Title",
                                placeholder: "placeholder",
                                isDynamic: true,
                                text: .constant("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."))
            }
            .padding()
        }
    }
}
