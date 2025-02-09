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
                                NoFinanceItemsView(item: viewModel.noFinanceItem)
                            } else {
                                ForEach(viewModel.financeItems) { item in
                                    FinanceItemView(item: item) { _ in
                                        Task {
                                            await viewModel.delete(item: item)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .scrollIndicators(.never)
                    
                    NextButton(title: "Kampány létrehozása", imageSystemName: "arrow.right") {
                        viewModel.showCreateFinanceItem.toggle()
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
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
