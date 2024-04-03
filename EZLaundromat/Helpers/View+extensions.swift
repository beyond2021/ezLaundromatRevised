//
//  View+extensions.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 3/9/24.
//

import SwiftUI

// To Use the custom font on all pages..
let customFont = "Raleway-Regular"
let secondaryFont = "Helvetica Black Condensed"

// Button Modifier
struct EZButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.primary)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .contentShape(.capsule)
            .background {
                Capsule()
                    .stroke(Color.primary, lineWidth: 0.5)
            }
        
    }
}
struct WhiteEZButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.white)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .contentShape(.capsule)
            .background {
                Capsule()
                    .stroke(Color.white, lineWidth: 0.5)
            }
        
    }
}
extension View {
    func  whiteEZButtonStyle() -> some View {
        modifier(WhiteEZButton())
    }
    func  ezButtonStyle() -> some View {
        modifier(EZButton())
    }
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
}

