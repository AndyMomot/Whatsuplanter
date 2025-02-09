import SwiftUI

struct StartCalculationView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.leafGreen.ignoresSafeArea()
                Asset.background.swiftUIImage
                    .resizable()
                
                VStack(spacing: 16) {
                    NavigationBarView(title: "Környezetvédelmi költségvetési kalkulátor")
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            NoFinanceItemsView(item: viewModel.noCalculationItem)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .scrollIndicators(.never)
                    
                    NextButton(title: "Kampány létrehozása", imageSystemName: "arrow.right") {
                        viewModel.showCalculator.toggle()
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationDestination(isPresented: $viewModel.showCalculator) {
                CalculatorInputsView()
            }
        }
    }
}

#Preview {
    StartCalculationView()
}
