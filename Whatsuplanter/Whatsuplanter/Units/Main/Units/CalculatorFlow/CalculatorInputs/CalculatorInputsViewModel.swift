//
//  CalculatorInputsViewModel.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 09.02.2025.
//

import Foundation
import SwiftUI

extension CalculatorInputsView {
    final class ViewModel: ObservableObject {
        @Published var seedlingsAndPlantsCosts = ""
        @Published var soilAndFertilizerCosts = ""
        @Published var toolsAndEquipmentCosts = ""
        @Published var benchesAndDecorationCosts = ""
        @Published var marketingCosts = ""
        
        @Published var purposeOfCollectionIncome = ""
        @Published var estimatedDonationsIncome = ""
        @Published var sponsorshipSupportIncome = ""
        
        let basePlaceholder = "Adja meg az összeget"
        
        var calculationModel: CalculationModel?
        @Published var showResults = false
        
        func createCalculationModel() async {
            let model = CalculationModel(
                costItems: [
                    .init(name: "Palánták és növények",
                          value: Double(seedlingsAndPlantsCosts) ?? .zero,
                          color: .red),
                    .init(name: "Talaj és műtrágya",
                          value: Double(soilAndFertilizerCosts) ?? .zero,
                          color: .blue),
                    .init(name: "Eszközök és szerszámok",
                          value: Double(toolsAndEquipmentCosts) ?? .zero,
                          color: .green),
                    .init(name: "Padok és dekoráció",
                          value: Double(benchesAndDecorationCosts) ?? .zero,
                          color: .yellow),
                    .init(name: "Marketing",
                          value: Double(marketingCosts) ?? .zero,
                          color: .purple)
                ],
                incomeItems: [
                    .init(name: "A gyűjtés célja",
                          value: Double(purposeOfCollectionIncome) ?? .zero,
                          color: .red),
                    .init(name: "Becsült adományok",
                          value: Double(estimatedDonationsIncome) ?? .zero,
                          color: .blue),
                    .init(name: "Szponzori támogatás",
                          value: Double(sponsorshipSupportIncome) ?? .zero,
                          color: .green)
                ])
            
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.calculationModel = model
                self.showResults.toggle()
            }
        }
    }
}

extension CalculatorInputsView {
    struct CalculationModel: Identifiable {
        private(set) var id = UUID().uuidString
        var costItems: [CalculationItem]
        var incomeItems: [CalculationItem]
        
        var totalCost: Double { costItems.map { $0.value }.reduce(0) { $0 + $1} }
        var totalIncome: Double { incomeItems.map { $0.value }.reduce(0) { $0 + $1} }
        var shortfall: Double { totalIncome - totalCost }
        
        var costsChartData: [CalculationItem] { getChartData(from: costItems) }
        var incomeChartData: [CalculationItem] { getChartData(from: incomeItems) }
        
        
        private func getChartData(from array: [CalculationItem]) -> [CalculationItem] {
            let totalDouble = Double(array.map { $0.value }.reduce(0) { $0 + $1})
            var items = [CalculationItem]()
            
            array.forEach { item in
                let valueDouble = Double(item.value)
                let percent = (valueDouble / totalDouble) * 100
                items.append(.init(name: item.name,
                                   value: percent.isNaN ? 0 : percent,
                                   color: item.color))
            }
            
            return items
        }
    }
}

extension CalculatorInputsView.CalculationModel {
    struct CalculationItem: Identifiable {
        private(set) var id = UUID().uuidString
        let name: String
        let value: Double
        var color: Color?
    }
}


