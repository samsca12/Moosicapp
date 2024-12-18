//
//  MoosicappApp.swift
//  Moosicapp
//
//  Created by Samuel Scalise on 09/12/24.
//

import SwiftUI

@main
struct MoosicappApp: App {
    @State private var showSplashScreen = true

       var body: some Scene {
           WindowGroup {               
               if showSplashScreen {
                   SplashScreenView {
                       showSplashScreen = false
                   }
               } else {
                   ContentView()
               }
           }
       }
}
