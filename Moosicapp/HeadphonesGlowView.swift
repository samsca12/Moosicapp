//
//  NotaGlowView.swift
//  Moosicapp
//
//  Created by Samuel Scalise on 16/12/24.
//

import SwiftUI

struct HeadphonesGlowView: View {
    @State private var isGlowing = false
    
    var body: some View {
        
        
        
        
        
        VStack {
            
           
            HStack{
                Text("Mood")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.top, 25)
                Spacer()
                
                
                
            }
            .padding(.top, -10)
            .padding(.horizontal, 25)
            
            
            ZStack {
                
               // Set Glow and animation "Headphones"
                Image("headphones")
                    .resizable()
                    .scaledToFit()
                
                    .cornerRadius(15)
                    .shadow(color: Color.white.opacity(isGlowing ? 0.5 : 1), radius: isGlowing ? 20 : 10, x: 0, y: 1)
                    .shadow(color: .white.opacity(0.3), radius: 10.0)
                    .offset(y: -15)
                    .opacity(1)
                    .animation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true),
                        value: isGlowing
                    )
                // Toggle Animation (called it isGLowing)
                    .onAppear {
                        isGlowing.toggle()
                        
                        
                    }
                    .padding(.top, -50)
            }
            
            
            
        }
        
    }
    
}
struct HeadphonesGlowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

