//
//  FinanceView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import SwiftUI

struct FinanceView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.leafGreen.ignoresSafeArea()
                Asset.background.swiftUIImage
                    .resizable()
                
                VStack(spacing: 16) {
                    NavigationBarView(title: "Hozza létre saját közösségi finanszírozási kampányát")
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            if viewModel.financeItems.isEmpty {
                                NoFinanceItemsView {
                                    viewModel.showCreateFinanceItem.toggle()
                                }
                            } else {
                                ForEach(viewModel.financeItems) { item in
                                    Text(item.name)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .scrollIndicators(.never)
                }
            }
            .onAppear {
                Task {
                    await viewModel.getFinanceItems()
                }
            }
            .navigationDestination(isPresented: $viewModel.showCreateFinanceItem) {
                CreateFinanceItemView()
            }
        }
    }
}

#Preview {
    FinanceView()
}
