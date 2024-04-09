//
//  LikeView.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 4/4/24.
//

import SwiftUI

struct LikeView: View {
      @State private var pinkBorder: Bool = true
      @State private var opacity: CGFloat = 0.0
      @State private var scaleHeart: CGFloat = 0.0
      @State private var scaleText: CGFloat = 1
      @Binding var isLiked: Bool
      
      var body: some View {
        ZStack {
          Color.appBlue.ignoresSafeArea()
          VStack {
            ZStack {
              Image(systemName: "heart")
                .font(.system(size: 64))
                .foregroundColor(.white)
              
              Image(systemName: "heart")
                .font(.system(size: 64))
                .foregroundColor(pinkBorder ? .pink : .white)
                .animation(Animation.interpolatingSpring(stiffness: 170, damping: 10).delay(0.25))
              
              Image(systemName: "heart.fill")
                .font(.system(size: 64))
                .foregroundColor(.pink)
                .scaleEffect(scaleHeart)
                .animation(Animation.interpolatingSpring(stiffness: 170, damping: 10).delay(0.5))
            }
            .onTapGesture {
              isLiked.toggle()
              pinkBorder.toggle()
              opacity += 1
              scaleHeart += 1
              scaleText = 1.2
              if !isLiked {
                pinkBorder = false
                scaleHeart = 0
                isLiked = false
                scaleText = 1
              }
            }
            Text(isLiked ? "500" : "499")
              .foregroundColor(isLiked ? .pink : .white)
              .scaleEffect(scaleText)
              .fontWeight(.heavy)
              .animation(Animation.interpolatingSpring(stiffness: 170, damping: 10).delay(0.5))
              .padding(.top, 2)
          }
        }
      }
}

#Preview {
    LikeView(isLiked:.constant(true))
}
