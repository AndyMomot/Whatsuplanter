//
//  CalculatorInputsView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 09.02.2025.
//

import SwiftUI

struct CalculatorInputsView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.leafGreen.ignoresSafeArea()
            Asset.background.swiftUIImage
                .resizable()
            
            VStack(alignment: .leading, spacing: 16) {
                NavigationBarView(
                    title: "A kiadások és bevételek megadása",
                    showBackButton: true
                )
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Adja hozzá a projekt fő költségeit:")
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                        
                        CustomTextField(
                            title: "Palánták és növények",
                            placeholder: viewModel.basePlaceholder,
                            text: $viewModel.seedlingsAndPlantsCosts)
                        
                        CustomTextField(
                            title: "Talaj és műtrágya",
                            placeholder: viewModel.basePlaceholder,
                            text: $viewModel.soilAndFertilizerCosts)
                        
                        CustomTextField(
                            title: "Eszközök és szerszámok",
                            placeholder: viewModel.basePlaceholder,
                            text: $viewModel.toolsAndEquipmentCosts)
                        
                        CustomTextField(
                            title: "Padok és dekoráció",
                            placeholder: viewModel.basePlaceholder,
                            text: $viewModel.benchesAndDecorationCosts)
                        
                        CustomTextField(
                            title: "Marketing",
                            placeholder: viewModel.basePlaceholder,
                            text: $viewModel.marketingCosts)
                        
                        Divider()
                        
                        Text("Adja hozzá a projekt fő költségeit:")
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                        
                        CustomTextField(
                            title: "A gyűjtés célja",
                            placeholder: viewModel.basePlaceholder,
                            text: $viewModel.purposeOfCollectionIncome)
                        
                        CustomTextField(
                            title: "Becsült adományok",
                            placeholder: viewModel.basePlaceholder,
                            text: $viewModel.estimatedDonationsIncome)
                        
                        CustomTextField(
                            title: "Szponzori támogatás",
                            placeholder: viewModel.basePlaceholder,
                            text: $viewModel.sponsorshipSupportIncome)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .keyboardType(.numberPad)
                    .hideKeyboardWhenTappedAround()
                }
                .scrollIndicators(.never)
                
                NextButton(title: "Egyenleg kiszámítása", imageSystemName: "arrow.right") {
                    Task {
                        await viewModel.createCalculationModel()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationDestination(isPresented: $viewModel.showResults) {
            if let item = viewModel.calculationModel {
                CalculationResultsView(item: item)
            }
        }
    }
}

#Preview {
    CalculatorInputsView()
}
