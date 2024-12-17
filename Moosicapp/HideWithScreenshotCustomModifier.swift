//
//  HideWithScreenshotCustomModifier.swift
//  Moosicapp
//
//  Created by Samuel Scalise on 10/12/24.
//

import SwiftUI

struct HideWithScreenshot: ViewModifier {
    @State private var size: CGSize?

    func body(content: Content) -> some View {
        ScreenshotPreventView {
            ZStack {
                content
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    size = proxy.size
                                }
                        }
                    )
            }
        }
        .frame(width: size?.width, height: size?.height)
    }
}
extension View {
    func hideWithScreenshot() -> some View {
        modifier(HideWithScreenshot())
    }
}
