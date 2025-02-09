//
//  CalculationResultsView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 09.02.2025.
//

import SwiftUI

struct CalculationResultsView: View {
    let item: CalculatorInputsView.CalculationModel
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.leafGreen.ignoresSafeArea()
            Asset.background.swiftUIImage
                .resizable()
            
            VStack(alignment: .leading, spacing: 16) {
                NavigationBarView(
                    title: "Pénzügyi jelentés",
                    showBackButton: true
                )
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Az Ön környezetvédelmi költségvetése")
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                        
                        costsIncomeView
                        
                        if viewModel.user.targetAmount > .zero {
                            goalProgress
                        }
                        
                        CalculationChart(
                            title: "Mérleg Táblázat",
                            items: item.costsChartData)
                        
                        Divider()
                        
                        CalculationChart(
                            title: "Finanszírozási ütemterv",
                            items: item.incomeChartData)
                        
                        Text("Mérlegtáblázat")
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                        
                        adviceView(text: "Komposzt használata műtrágya helyett (+ 20.000 megtakarítás) ")
                        adviceView(text: "oborozzon önkénteseket a faültetéshez (+ 30,000  megtakarítás)  ")
                        adviceView(text: "Keressünk szponzorokat a helyi cégek között (+ 50,000 lehetséges finanszírozása)  ")
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .scrollIndicators(.never)
                
                HStack {
                    NextButton(title: "Szerkesztés", imageSystemName: "pencil.line") {
                        dismiss.callAsFunction()
                    }
                    
                    NextButton(title: "Szerkesztés",
                               imageSystemName: "square.and.arrow.up") {
                        Task {
                            guard let screenshot = captureScreenshot() else { return }
                            share(items: [screenshot])
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .onAppear {
            Task {
                await viewModel.getUser()
            }
        }
    }
}

private extension CalculationResultsView {
    var costsIncomeView: some View {
        DashedContainerView {
            VStack(alignment: .leading, spacing: 10) {
                costsIncomeRow(image: Asset.costs.name,
                               title: "Teljes költség:",
                               text: Double(item.totalCost).string(usesSeparator: true))
                
                costsIncomeRow(image: Asset.income.name,
                               title: "Bevont pénzeszközök:",
                               text: Double(item.totalIncome).string(usesSeparator: true))
                
                costsIncomeRow(image: Asset.shortfall.name,
                               title: item.shortfall < .zero ? "Hiány:" : "Nettó nyereség:",
                               text: Double(item.shortfall).string(usesSeparator: true))
            }
        }
    }
    
    func costsIncomeRow(image: String, title: String, text: String) -> some View {
        HStack(spacing: 8) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 24)
            Text(title)
                .foregroundColor(.black)
                .font(Fonts.DMSans.bold.swiftUIFont(size: 14))
            + Text(" ") +
            Text(text)
                .foregroundColor(.charcoalGray)
                .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
            
            Spacer()
        }
    }
    
    var goalProgress: some View {
        DashedContainerView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Begyűjtendő cél ")
                    .foregroundStyle(.black)
                    .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                
                VStack(spacing: 0) {
                    ProgressView(value: Double(viewModel.user.currentAmount),
                                 total: Double(viewModel.user.targetAmount))
                    .tint(.leafGreen)
                    
                    HStack {
                        Text("\(Int(viewModel.user.currentAmount))")
                        Spacer()
                        Text("\(Int(viewModel.user.targetAmount))")
                    }
                    .foregroundStyle(.black)
                    .font(Fonts.DMSans.regular.swiftUIFont(size: 12))
                }
            }
        }
    }
    
    func adviceView(text: String) -> some View {
        HStack(spacing: 8) {
            Asset.advice.swiftUIImage
            Text(text)
                .foregroundStyle(.black)
                .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
        }
    }
}

#Preview {
    CalculationResultsView(item: .init(
        costItems: [
            .init(name: "Palánták és növények",
                  value: Double(43214) ?? .zero,
                  color: .red),
            .init(name: "Talaj és műtrágya",
                  value: Double(43214) ?? .zero,
                  color: .blue),
            .init(name: "Eszközök és szerszámok",
                  value: Double(432143) ?? .zero,
                  color: .green),
            .init(name: "Padok és dekoráció",
                  value: Double(324321) ?? .zero,
                  color: .yellow),
            .init(name: "Marketing",
                  value: Double(4321) ?? .zero,
                  color: .purple)
        ],
        incomeItems: [
            .init(name: "A gyűjtés célja",
                  value: Double(5432543) ?? .zero,
                  color: .red),
            .init(name: "Becsült adományok",
                  value: Double(543254) ?? .zero,
                  color: .blue),
            .init(name: "Szponzori támogatás",
                  value: Double(5432523) ?? .zero,
                  color: .green)
        ]
    ))
}
