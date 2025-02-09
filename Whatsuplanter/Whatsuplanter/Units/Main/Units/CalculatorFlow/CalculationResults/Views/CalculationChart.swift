//
//  CalculationChart.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 09.02.2025.
//

import SwiftUI
import Charts

struct CalculationChart: View {
    let title: String
    let items: [CalculatorInputsView.CalculationModel.CalculationItem]
    var goal: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(title)
                .foregroundStyle(.black)
                .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
            
            Chart {
                if let goal {
                    RuleMark(y: .value("Cél", goal))
                        .foregroundStyle(.orange)
                        .lineStyle(.init(lineWidth: 1, dash: [5]))
                        .annotation(alignment: .leading) {
                            Text("Cél")
                                .foregroundStyle(.secondary)
                                .font(.caption)
                        }
                }
                
                ForEach(items) { cost in
                    BarMark(
                        x: .value("1", "\(cost.name.prefix(3)) \(cost.value.string())%"),
                        y: .value("2", cost.value)
                    )
                    .foregroundStyle(cost.color ?? .leafGreen)
                    .cornerRadius(16)
                }
            }
            .chartXAxis {
                AxisMarks { value in
                    AxisValueLabel {
                        Text("\(value.as(String.self) ?? "")")
                            .foregroundColor(.black)
                            .font(Fonts.DMSans.regular.swiftUIFont(size: 10))
                            .minimumScaleFactor(0.5)
                    }
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisValueLabel {
                        Text("\(value.as(Int.self) ?? 0)")
                            .foregroundColor(.black)
                            .font(Fonts.DMSans.bold.swiftUIFont(size: 10))
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(items) { cost in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(cost.color ?? .gray)
                            .frame(width: 10)
                        
                        Text(cost.name)
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.regular.swiftUIFont(size: 9))
                    }
                }
            }
        }
    }
}

#Preview {
    CalculationChart(title: "Mérleg Táblázat",
                     items: [
        .init(name: "Palánták és növények",
              value: 4124,
              color: .red),
        .init(name: "Talaj és műtrágya",
              value: 4124,
              color: .blue),
        .init(name: "Eszközök és szerszámok",
              value: 43221,
              color: .green),
        .init(name: "Padok és dekoráció",
              value: 43214,
              color: .yellow),
        .init(name: "Marketing",
              value: 45214,
              color: .purple)
    ])
    .padding()
}
