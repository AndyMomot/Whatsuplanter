//
//  CustomTextField.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 02.12.2024.
//

import SwiftUI

struct CustomTextField: View {
    var title: String = ""
    var titleColor: Color = .black
    var placeholder: String = ""
    var isDynamic = false
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(Fonts.DMSans.medium.swiftUIFont(size: 16))
                .foregroundStyle(titleColor)
            
            if isDynamic {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .scrollIndicators(.never)
                        .foregroundStyle(.steelGray)
                        .font(Fonts.DMSans.regular.swiftUIFont(size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                    
                    
                    if text.isEmpty {
                        createPlaceholder(text: placeholder,
                                          isDynamic: isDynamic)
                    }
                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(minHeight: 60)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.steelGray, lineWidth: 1)
                        .padding(1)
                }
                
            } else {
                TextField(text: $text) {
                    createPlaceholder(text: placeholder,
                                      isDynamic: isDynamic)
                }
                .font(Fonts.DMSans.regular.swiftUIFont(size: 16))
                .foregroundStyle(.steelGray)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.steelGray, lineWidth: 1)
                        .padding(1)
                }
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
            .foregroundStyle(.steelGray)
            .padding(.horizontal, isDynamic ? 12 : 0)
            .padding(.vertical, isDynamic ? 27 : 0)
            .allowsHitTesting(false)
    }
}

#Preview {
    ZStack {
        Color.blue
        
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
