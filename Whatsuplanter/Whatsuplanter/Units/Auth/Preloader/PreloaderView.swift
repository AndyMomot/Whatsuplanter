//
//  PreloaderView.swift

import SwiftUI

struct PreloaderView: View {
    
    var onDidLoad: () -> Void
    
    @State private var timer: Timer?
    @State private var progress: Double = 0.0
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.background.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Asset.logo.swiftUIImage
                    .scaledToFit()
                    .padding(.horizontal, 78)
                
                Text("Whatsuplanter")
                    .foregroundStyle(.black)
                    .font(.system(size: 35, weight: .black))
            }
            
            VStack(spacing: 14) {
                Spacer()
                CircularProgressBar(
                    progress: progress,
                    trackColor: .silverGray,
                    progressColor: .leafGreen,
                    lineWidth: 8,
                    lineCap: .round
                )
                .frame(width: 48, height: 48)
                
                Text("Betöltés...")
                    .foregroundStyle(.black)
                    .font(Fonts.DMSans.regular.swiftUIFont(size: 24))
            }
            .padding(.horizontal)
        }
        .onAppear {
            startTimer()
        }
    }
}

private extension PreloaderView {
    func startTimer() {
        stopTimer()
        
        timer = .scheduledTimer(withTimeInterval: 0.01,
                                repeats: true, block: { timer in
            updateProgress(value: 0.005)
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateProgress(value: Double) {
        DispatchQueue.main.async {
            if progress + value > 1 {
                withAnimation {
                    progress = 1
                }
                stopTimer()
                onDidLoad()
            } else {
                withAnimation {
                    progress = progress + value
                }
            }
        }
    }
}

#Preview {
    PreloaderView {}
}
