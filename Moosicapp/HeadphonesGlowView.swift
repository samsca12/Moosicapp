//
//  NotaGlowView.swift
//  Moosicapp
//
//  Created by Samuel Scalise on 16/12/24.
//

import SwiftUI

struct HeadphonesGlowView: View {
    
    
    @State private var isGlowing: Bool = false
    
    var body: some View {
        
        
        
        //        Spacer()
        
        
        VStack {
            
            
            
            HStack{
                Text("Mood")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                //                    .padding(.top, 25)
                    .accessibilityLabel("Mood")
                Spacer()
                
                
                
            }
            .padding(.top)
            .padding(.horizontal, 25)
            
            
            ZStack {
                
                
                // Set Glow and animation "Headphones"
                Image("headphones")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .shadow(color: Color.white.opacity(isGlowing ? 0.5 : 1), radius: isGlowing ? 20 : 10, x: 0, y: 1)
                    .shadow(color: .white.opacity(0.3), radius: 10.0)
                    .offset(y: isGlowing ? 15 : -15)
                    .opacity(1)
                    .animation(
                        .easeInOut(duration: 1)
                            .repeatForever(autoreverses: true),
                        value: isGlowing
                    )
                    .onTapGesture {
                        isGlowing.toggle()
                        
                    }
                            }
                    }
              
            }
            
            
            
        }
        
    
    


#Preview {
    ContentView()
}


