//
//  SplashScreenView.swift
//  Moosicapp
//
//  Created by Samuel Scalise on 18/12/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var showFirstImage = true
    var onFinish: () -> Void // Closure to signal completion
    
    var body: some View {
        ZStack {
            if showFirstImage {
                Image("SP1")
                    .resizable()
                    .scaledToFit()
                    .transition(.opacity)
                    .accessibilityLabel("Image of a person")
            } else {
                Image("SP2")
                    .resizable()
                    .scaledToFit()
                    .transition(.opacity)
                    .accessibilityLabel("Image of a person listening to music")
            }
        }
        .onAppear {
            // Animate the transition between images
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showFirstImage = false
                }
                // Navigate to ContentView after animation completes
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    onFinish()
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView {
            print("Splash screen finished") // Example action for preview
        }
        .previewLayout(.device)
    }
}

